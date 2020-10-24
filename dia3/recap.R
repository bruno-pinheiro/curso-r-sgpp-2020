# Recap

# select
# filter
# mutate
# summarise
# group_by

# Carregar libs
library(tidyverse)
library(sf)

# Importar os dados

## Importar dados csv
cultura <- read.csv('dados/cultura.csv')

## Importar dados espaciais (shp)
cultura_geo <- read_sf('dados/preparados/distritos_cultura.shp')

# Visualizar início dos dados
head(cultura)

# Visualizar o final dos dados
tail(cultura)

# Selecionar

# sintaxe do tidyver
cultura %>% select(bibliotecas, museus) %>% head
cultura %>% select(contains("bib")) %>% head
cultura_geo %>% select(contains("rn")) %>% head

# Faz o mesmo que acima (sintaxe base do R)
head(select(cultura, bibliotecas, museus))


# Filtrar os dados

## Sintaxe do tidyverse
 # igual a
cultura %>% filter(bibliotecas != 0) %>% head # diferente de
cultura %>% filter(bibliotecas > 0) %>% head # maior que
cultura %>% filter(bibliotecas >= 5) %>% head # maior ou igual que
cultura %>% filter(bibliotecas > 5 & museus > 10) %>% head # maior que
cultura %>% filter(bibliotecas > 5 | museus > 10) %>% head # maior que

## Sintaxe base do R
head(cultura[cultura$bibliotecas == 0, ])
cultura[cultura$bibliotecas > 10, ]
cultura %>% filter(bibliotecas > 10)
filter(cultura, bibliotecas > 10)


## Criação de novas variávei

cultura %>% 
  mutate(bibs_museus = bibliotecas + museus,
         bibs_teatro = bibliotecas + teatro_cinema,
         bibs_outros = bibliotecas + outros) %>% 
  head


cultura$bibs_museus <- cultura$bibliotecas + cultura$museus
cultura$bibs_teatros<- cultura$bibliotecas + cultura$teatro_cinema
cultura$bibs_outros <- cultura$bibliotecas + cultura$outros




## Summarise (resumos)

cultura %>% summarise(media_bib = mean(bibliotecas),
                      media_tea = mean(teatro_cinema))


cultura_geo %>% 
  data.frame %>% 
  group_by(bibltcs) %>% 
  summarise(media = mean(rnd_dm_))


cultura_geo %>% 
  data.frame %>% 
  group_by(museus) %>% 
  summarise(media_dm = mean(rnd_dm_),
            media_pc = mean(rend_pc))

cultura_geo %>% 
  data.frame %>% 
  summarise(media_dm = mean(rnd_dm_),
            media_pc = mean(rend_pc))



