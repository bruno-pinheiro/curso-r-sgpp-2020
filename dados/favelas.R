# IMPORTAR PACOTES ------------------
print('Iniciando processo das Favelas')


library(dplyr)
library(sf)
library(tidyr)
library(purrr)
library(ggplot2)

# BAIXAR OS DADOS ------------------

file_url <- "http://geosampa.prefeitura.sp.gov.br/PaginasPublicas/downloadArquivoOL.aspx?orig=DownloadCamadas&arq=06_Habita%E7%E3o%20e%20Edifica%E7%E3o%5C%5CFavelas_Loteamentos_Nucleos%5C%5CShapefile%5C%5CSIRGAS_SHP_favela&arqTipo=Shapefile"
dir_path <- "dados/favelas-raw"
file_path <- "dados/favelas-raw/favelas-geosampa.zip"

if (length(list.files(dir_path)) == 0){
  if (!file.exists(dir_path)){
    dir.create(dir_path) 
  }
  download.file(url = file_url, destfile = file_path)
  unzip(file_path, junkpaths = TRUE, exdir = dir_path)
  
  # IMPORTAR OS DADOS ------------------
  
  favelas <- st_read("dados/favelas-raw/SIRGAS_SHP_favela.shp", options = "ENCODING=windows-1252")
  
  ## Também vou importar o distritos para realizar a intersecção das favelas
  ## com os distritos e descobrir a área de favelas em cada um dos distritos
  
  distritos <- read_sf("dados/distritos_geo/distritos_geo.shp")
  
  # LIMPAR E PREPARAR OS DADOS ------------------
  
  distritos <- distritos %>% 
    select(cod_distrito = cd_dstr) %>% 
    st_transform(31983)
  
  favelas <- favelas %>% 
    st_set_crs(31983) %>% 
    st_set_precision(10^6) %>%
    st_make_valid() %>% 
    st_join(distritos, join = st_intersects) %>% 
    mutate(area_favela = as.numeric(st_area(geometry)) / 10^6) %>% 
    group_by(cod_distrito) %>% 
    summarise(area_favela = sum(area_favela))
  
  # EXPORTAR OS DADOS ------------------
  
  st_write(favelas, "dados/favelas.csv")
  
  # LIMPAR AMBIENTE DE TRABALHO
  
  rm(list = ls())
}

