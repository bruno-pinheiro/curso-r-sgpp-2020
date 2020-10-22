print('Iniciando processo final')

library(sf)
library(dplyr)

censo <- read.csv("dados/censo.csv")
cultura <- read.csv("dados/cultura.csv")
distritos <- read.csv("dados/distritos.csv")
distritos_geo <- read_sf("dados/distritos_geo/distritos_geo.shp")

censo <- censo %>% 
  mutate(pessoas = brancos + pretos + pardos + amarelos + indigenas,
         renda_dom_media = renda_domicilios / domicilios,
         renda_pc = renda_domicilios / pessoas)

cultura <- cultura %>% 
  mutate(equipamentos = bibliotecas + teatro_cinema + outros + espacos_culturais + museus)

distritos <- distritos %>%
  merge(censo, by = "cod_distrito") %>% 
  merge(cultura, by = "cod_distrito")

distritos_geo <- distritos_geo %>% 
  rename(cod_distrito = cd_dstr) %>% 
  merge(distritos, by = "cod_distrito")

glimpse(distritos_geo)


if (!file.exists("dados/preparados/")){
  dir.create("dados/preparados/")
}
write_sf(distritos_geo, "dados/preparados/distritos_cultura.shp")

