# IMPORTAR PACOTES ------------------

library(dplyr)
library(sf)
library(tidyr)
library(purrr)

# BAIXAR OS DADOS ------------------

if (!file.exists("dados/cultura-raw")){
  dir.create("dados/cultura-raw")
  download.file("http://geosampa.prefeitura.sp.gov.br/PaginasPublicas/downloadArquivoOL.aspx?orig=DownloadCamadas&arq=03_Equipamentos%5C%5CCultura%5C%5CShapefile%5C%5CEQUIPAMENTOS_SHP_TEMA_CULTURA&arqTipo=Shapefile",
                destfile = "dados/cultura-raw/cultura-geosampa.zip")
  unzip("dados/cultura-raw/cultura-geosampa.zip", junkpaths = TRUE, exdir = "dados/cultura-raw")
}

# IMPORTAR OS DADOS ------------------

equipamentos_cultura <- c("bibliotecas", "espacos_culturais", "museus", "outros", "teatro_cinema")
shapes_cultura <- list.files("dados/cultura-raw")[grepl(".*SIRGAS.*CULTURA.*shp", list.files("dados/cultura-raw"))]

cultura <- map2(
  shapes_cultura, equipamentos_cultura,
  ~read_sf(paste0("dados/cultura-raw/", .x), options = "ENCODING=windows-1252") %>% 
    mutate(tipo = .y) %>% 
    select(everything(), geometry)
  ) %>% 
  do.call(rbind, .)

## Também vou importar o distritos para realizar a intersecção das favelas
## com os distritos e descobrir a área de favelas em cada um dos distritos

distritos <- read_sf("dados/distritos_geo.shp")

# LIMPAR E PREPARAR OS DADOS ------------------

distritos <- distritos %>% 
  select(cod_distrito = cd_dstr) %>% 
  st_transform(31983)

cultura <- cultura %>% 
  st_set_crs(31983) %>% 
  st_join(distritos, join = st_intersects) %>% 
  as_tibble() %>% 
  count(cod_distrito, tipo) %>%
  spread(tipo, n) %>% 
  mutate_all(~replace_na(., 0)) %>%
  mutate(cod_distrito = as.character(cod_distrito)) %>% 
  rbind(data.frame(cod_distrito = distritos$cod_distrito[!(distritos$cod_distrito %in% .$cod_distrito)],
                   bibliotecas = rep(0, 5),
                   espacos_culturais = rep(0, 5),
                   museus = rep(0, 5),
                   outros = rep(0, 5),
                   teatro_cinema = rep(0, 5)))

# EXPORTAR OS DADOS ------------------

write_csv(cultura, "dados/cultura.csv")

# LIMPAR AMBIENTE DE TRABALHO

rm(list = ls())
