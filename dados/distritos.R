# IMPORTAR PACOTES ------------------

library(dplyr)
library(sf)
library(ggplot2)
library(tidyr)
library(purrr)

# BAIXAR OS DADOS ------------------

if (!file.exists("dados/distritos-raw")){
  dir.create("dados/distritos-raw")
  download.file("ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/sp/sp_distritos.zip",
                destfile = "dados/distritos-raw/sp_distritos.zip")
  unzip("dados/distritos-raw/sp_distritos.zip", junkpaths = TRUE, exdir = "dados/distritos-raw")
}

# IMPORTAR OS DADOS ------------------

distritos <- read_sf("dados/distritos-raw/35DSE250GC_SIR.shp", options = "ENCODING=windows-1252")

# LIMPAR E PREPARAR OS DADOS ------------------

distritos <- distritos %>%
  st_transform(31983) %>% 
  rename(cod_distrito = CD_GEOCODD, nome_distrito = NM_DISTRIT) %>% 
  filter(grepl(3550308, cod_distrito)) %>% 
  mutate(area_distrito = as.numeric(st_area(geometry)) / 10^6) %>% 
  select(cod_distrito, nome_distrito, area_distrito)

# EXPORTAR OS DADOS ------------------

distritos %>% 
  as_tibble() %>% 
  select(-geometry) %>% 
  write.csv("dados/distritos.csv", row.names = FALSE) # em formato tabular

distritos %>% 
  select(cod_distrito) %>% 
  st_write("dados/distritos_geo.shp") # em formato shapefile
