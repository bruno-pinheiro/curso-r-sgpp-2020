# IMPORTAR PACOTES ------------------
print('Iniciando processo dos Distritos')

library(dplyr)
library(sf)
library(ggplot2)
library(tidyr)
library(purrr)

# BAIXAR OS DADOS ------------------

file_url <- "ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/sp/sp_distritos.zip"
dir_path <- "dados/distritos-raw"
file_path <- "dados/distritos-raw/sp_distritos.zip"

if (length(list.files(dir_path)) == 0){
  if (!file.exists(dir_path)){
    dir.create(dir_path) 
  }
  download.file(url = file_url, destfile = file_path)
  unzip(file_path, junkpaths = TRUE, exdir = dir_path)
  
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
  
  
  if (!file.exists("dados/distritos_geo")){
    dir.create("dados/distritos_geo")
  }
  distritos %>% 
    select(cod_distrito) %>% 
    st_write("dados/distritos_geo/distritos_geo.shp") # em formato shapefile
}

