
## Libs

library(tidyverse)


### Utilizando os leitores auxiliares para ler e
### identificar os microdados de cada registro da POF

a <- list.files(path = "/Users/apple/Documents/pof_bd/auxiliary_files")
b <- paste0("/Users/apple/Documents/pof_bd/auxiliary_files/", a)

leitores <- purrr::map_df(b, 
              ~read.csv(.x, stringsAsFactors = FALSE) %>% 
                            mutate(filename = str_remove_all(.x, 
                                                pattern = "/Users/apple/Documents/pof_bd/auxiliary_files/|.csv"))) %>% 
                            as_tibble()
leitores %>%
    filter(filename == "leitores_rendimento_trabalho")


### Lendo os microdados de cada registro
### Domicílio
colpos_domicilio <- read_csv("./auxiliary_files/leitores_domicilio.csv")

pof_domicilio <- read_fwf(file = "./input/DOMICILIO.txt",
                          col_positions = leitores %>% filter(filename == "leitores_domicilio"),
                          col_types = cols(.default = col_character()))

### Morador

colpos_morador <- read_csv("./auxiliary_files/leitores_morador.csv")

pof_morador <- read_fwf(file = "./input/MORADOR.txt",
                          col_positions = colpos_domicilio,
                          col_types = cols(.default = col_character()))

### 

colpos_morador <- read_csv("./auxiliary_files/leitores_morador.csv")

pof_morador <- read_fwf(file = "./input/MORADOR.txt",
                          col_positions = colpos_domicilio,
                          col_types = cols(.default = col_character()))


####

c <- list.files(path = "/Users/apple/Documents/curso_pof_drive/dados/dados_rds") %>%
    str_remove_all(pattern = ".rds|pof_despesa.rds")

d <- list.files(path = "./input")

as_tibble_col(c, column_name = "nome") %>%
    mutate(file = a)

c
a %>%
    str_replace(pattern = "leitores", "pof") %>%
    str_remove(pattern = ".csv") %>%
    as_tibble_col(column_name = "nome") %>%
    mutate(file = a, fwf = d) %>%
    mutate(fwf = paste0("./input/", fwf),
           file = str_remove(file, ".csv")) %>%
    mutate(dados = map2(.x = file, .y = fwf, ~ read_fwf(
        file = .y,
        col_positions = leitores %>% filter(filename == .x),
        col_types = cols(.default = col_character()))
    )) -> df

df
write_rds(df, file = "microdados_pof_2017.rds")
