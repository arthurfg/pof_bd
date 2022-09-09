library(tidyverse)

pof_domicilio <- read_rds("./dados_rds/pof_domicilio.rds")


pof_domicilio <- pof_domicilio %>% 
  mutate(id_dom = str_c(COD_UPA, NUM_DOM))

pof_domicilio %>% 
  summarise(numero_domicilios = n_distinct(id_dom),
            numero_linhas = n())

pof_domicilio <- pof_domicilio %>% 
  mutate(NUM_DOM = str_pad(NUM_DOM, 2, "left", "0"),
         id_dom = str_c(COD_UPA, NUM_DOM))

pof_domicilio
