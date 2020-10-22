# IMPORTAR PACOTES ------------------
print('Iniciando processo do Censo')

library(dplyr)
library(readr)
library(tidyr)
library(purrr)
library(ggplot2)

# BAIXAR OS DADOS ------------------

file_url <- "ftp://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_do_Universo/Agregados_por_Setores_Censitarios/SP_Capital_20190823.zip"
dir_path <- "dados/censo-raw"
file_path <- "dados/censo-raw/SP_Capital_20190823.zip"

if (length(list.files(dir_path)) == 0){
  if (!file.exists(dir_path)){
    dir.create(dir_path) 
  }
  download.file(url = file_url, destfile = file_path)
  unzip(file_path, junkpaths = TRUE, exdir = dir_path)
  
  # DELETAR ARQUIVOS QUE NÃO SERÃO USADOS
  
  lista_remocao <- list.files(dir_path)[
    !grepl("Pessoa03.*csv|Domicilio01.*csv|DomicilioRenda.*csv|SP_Capital",
           list.files(dir_path))
    ]
  sapply(paste0("rm dados/censo-raw/", lista_remocao), function(x) system(x))
  rm(lista_remocao)
  
  # IMPORTAR OS DADOS ------------------
  
  pessoa <- read.csv("dados/censo-raw/Pessoa03_SP1.csv", sep = ";")
  domicilio <- read.csv("dados/censo-raw/Domicilio01_SP1.csv", sep = ";")
  renda <- read.csv("dados/censo-raw/DomicilioRenda_SP1.csv", sep = ";")
  
  # LIMPAR E PREPARAR OS DADOS ------------------
  
  # Domicilio01_SP1.csv
  ## V002: domicílios particulares permanentes
  domicilio <- domicilio %>% 
    mutate(cod_distrito = as.numeric(substr(Cod_setor, 1, 9)),
           domicilios = as.numeric(as.character(V002))) %>% 
    group_by(cod_distrito) %>% 
    summarise(domicilios = sum(domicilios, na.rm = TRUE))
  
  # DomicilioRenda_SP1.csv
  ## V002: Total do rendimento nominal mensal dos domicílios particulares
  renda <- renda %>% 
    mutate(cod_distrito = as.numeric(substr(Cod_setor, 1, 9)),
           renda_domicilios = as.numeric(as.character(V002))) %>% 
    group_by(cod_distrito) %>% 
    summarise(renda_domicilios = sum(renda_domicilios, na.rm = TRUE))
  
  # Pessoa03_SP1.csv
  ## V002:V006 (Pessoas residentes da cor branca, preta, amarela, parda, indígena)
  pessoa <- pessoa %>%
    select(Cod_setor, V002:V006) %>%
    setNames(c("cod_distrito", "brancos", "pretos", "amarelos", "pardos", "indigenas")) %>% 
    mutate(cod_distrito = as.numeric(substr(cod_distrito, 1, 9))) %>% 
    mutate_at(vars(-cod_distrito), ~as.numeric(as.character(.))) %>% 
    group_by(cod_distrito) %>% 
    summarise_all(~sum(., na.rm = TRUE))
  
  # MESCLAR OS DADOS DEMOGRAFICOS E DE RENDA DOS DISTRITOS ------------------------
  
  censo <- pessoa %>%
    merge(domicilio, by = "cod_distrito") %>% 
    merge(renda, by = "cod_distrito")
  
  # EXPORTAR OS DADOS ------------------
  
  write_csv(censo, "dados/censo.csv")
}

