###### AVALIACAO FINAL da disciplina "Gestao de Dados e Graficos no R", Gustavo Paterno e Carlos Fonseca, 2019
  # LARA LOPES
  # Last update: 2019-10-31

# A felicidade humana e influenciada pela renda per capita e pelo nível de direitos sociais do seu pais?
  #h1: O PIB do país influencia o nivel de felicidade da população.
  #h2: O cumprimento de direitos humanos do país influencia o nivel de felicidade da população.
  # h3: O efeito do cumprimento de direitos humanos sobre o nivel de felicidade da populacao varia com o PIB.

# Fonte dos dados brutos: 
# hapiness: https://ourworldindata.org/happiness-and-life-satisfaction 
# human rights: https://ourworldindata.org/human-rights 


# Script para carregar e limpar dados brutos (hapiness and human rights)

# Start----
# Packages ---------------------------------------------------------

library(tidyverse) # muitos pacotes juntos
library(inspectdf) # pacote serve para inspecionar tabelas
library(forcats)

# Load data ---------------------------------------------------------------

rd_hapiness <- read.csv(file = "data/raw/gdp-vs-happiness2.csv")
rd_hrights <- read.csv(file = "data/raw/human-rights-scores.csv")

# 1. Basic checks ---------------------------------------------------

  # rd_hapiness
nrow(rd_hapiness)             # How many rows
str(rd_hapiness)              # Variables classes - CONFIRA BEM CADA VARIAVEL
attributes(rd_hapiness)       # Attributres
head(rd_hapiness)             # First rows
any(duplicated(rd_hapiness))  # False
any(is.na(rd_hapiness))       # True

  # rd_hrights
nrow(rd_hrights)             # How many rows
str(rd_hrights)              # Variables classes 
attributes(rd_hrights)       # Attributres
head(rd_hrights)             # First rows
any(duplicated(rd_hrights))  # False
any(is.na(rd_hrights))       # False

# 2. Rename columns names-------------------------------------------
  # dat hapiness
names(rd_hapiness)
dat_hap <- dplyr::rename(rd_hapiness, 
                     pais  = Entity,
                     codigo = Code,
                     ano  = Year,
                     PIB  = GDP.per.capita..constant.2011.international...,
                     felic_pais = Life.satisfaction..country.average.0.10.,
                     felic_ladder  = cantril.Ladder..0.worst..10.best.) # função rename do pacote dplyr para renomear o nome das colunas, salvando no objeto dat (esquerda é o novo, direita é o velho)
head(dat_hap) # confira se a renomeção deu certo

# dat human rights 
names(rd_hrights)
dat_hright <- dplyr::rename(rd_hrights, 
                         pais = Entity,
                         codigo = Code,
                         ano = Year, 
                         direito_h = Human.Rights.Protection.Scores.â...by.Christopher.Farris.and.Keith.Schnakenberg)
head(dat_hright)

# 2.1 Juntando tabelas ---------------------------------------------

dat <- full_join(x = dat_hap, y = dat_hright)

# filtering the temporal scale (1990-2019)

dat <- dat %>% 
  filter( ano > 1989) %>% 
    arrange(ano)

# selecting factor variables 

dat$ano <- as.factor(dat$ano)
dat$pais <- as.factor(dat$pais)
dat$codigo <- as.factor(dat$codigo)

# 3. Fix factor variables-------------------------------------------

# Verificando os fatores das variaveis
str(dat)
levels(dat$pais)
levels(dat$codigo)
levels(dat$ano)

# 4. Remove NAs-----------------------------------------------------

na_check <- inspectdf::inspect_na(dat) # Count and Percentage of NA in each columns
na_check # observa

# Which rows have NA?
dat[is.na(dat$freq) | is.na(dat$size), ]

# Remove NAs
dat <- na.omit(dat) # remove a linha inteira que contem nas

# Check (# should be all zero!)
inspectdf::inspect_na(dat) # Percentage of NA in each columns

# 5. Remove duplicated rows-----------------------------------------

# Which rows are duplicated?
any(duplicated(dat)) # nenhuma

# checkin table so far and select variables that will be used
dat <- dat %>% 
    select(pais, ano, PIB, felic_pais, direito_h)
str(dat)

# transform table
dat_clean <- dat

head(dat_clean)

# 6. Average Table ----------------------------------------------

any(table(dat$pais) > 1) # mais de uma observação para o mesmo pais
any(table(dat$ano) > 1) # mais de uma observação para o mesmo ano

dat_g <- group_by(dat, pais)

dat_sum_clean <- summarise(dat_g, 
                       n    = n(),
                       PIB = mean(PIB),
                       felic_pais = mean(felic_pais),
                       direito_h = mean(direito_h)
)
str(dat_sum_clean) # check

# Check data
nrow(dat_sum_clean)

# 7. Transform variables------------------------------

dat_sum_clean$PIB_log <- log(dat_sum_clean$PIB)
dat_sum_clean$felic_pais_log <- log(dat_sum_clean$felic_pais)

head(dat_sum_clean)

# 8. Save processed data -----------------------------
# datos completos
write.csv(x = dat_clean, 
          file = "data/processed/01_processed_hapiness_PIB_rights_data.csv", 
          row.names = FALSE) # row.names = F para não criar uma coluna x1 com a numeração das linhas em sequência

# tabela summary
write.csv(x = dat_sum_clean, 
          file = "data/processed/02_processed_sum_hapiness_PIB_rights_data.csv", 
          row.names = FALSE)

# Test saved data
dat_test <- read.csv("data/processed/01_processed_hapiness_PIB_rights_data.csv") # reimporta a tabela pra ver se deu certo
str(dat_test) # confira novamente se as variaveis estao ok

data_sum_test <- read.csv("data/processed/02_processed_sum_hapiness_PIB_rights_data.csv")
str(dat_test)

# END-------