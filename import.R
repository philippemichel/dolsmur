

#  ------------------------------------------------------------------------
#
# Title : Import provisoire
#    By : PhM
#  Date : 2023-03-12
#    
#  ------------------------------------------------------------------------


library(tidyverse)
library(labelled)
#
tt <- read_csv("datas/DOLSMUR.csv", na = c("NA","NC", " ", "-")) %>% 
  mutate_if(is.character,as.factor) %>% 
  janitor::clean_names()
bn <- read_csv("datas/bnom.csv")
bn <- bn$nom
var_label(tt) <- as.character(bn)
#
## Recodage de tt$douleur
tt$douleur <- tt$douleur %>%
  fct_recode(
    "non" = "abs"
  )
names(tt)[1] <- "id"
tt <- tt[,-2]


at <- read_csv("datas/atcd.csv", na = c("NC")) |> 
  mutate(atcd.cardio = str_detect(antecedent,"cardiopathie")) |> 
  mutate(atcd.cancer = str_detect(antecedent,"cancer")) |>
  mutate(atcd.diabete = str_detect(antecedent,"diabète")) |> 
  mutate(atcd.sas= str_detect(antecedent,"SAOS")) |>
  mutate(atcd.pneumo = str_detect(antecedent,"pulmonaire")) |> 
  mutate(atcd.neuro = str_detect(antecedent,"neurologique")) |> 
  mutate(atcd.psy = str_detect(antecedent,"psychiatrique")) |> 
  mutate(atcd.chir = str_detect(antecedent,"chirurgie")) |> 
  mutate(atcd.aucun = str_detect(antecedent,"aucun")) |> 
  select(-2)

tt <- left_join(tt,at,'id') |> 
  select(-5)
var_label(tt[,19:27]) <- c("Cardiologique","Cancer","Diabète","SAOS","Pneumologique", "Neurologique","Psychiatrique","Chirugical","Aucun")  
  
  
  


