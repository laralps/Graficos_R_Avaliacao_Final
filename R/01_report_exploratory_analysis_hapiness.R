###### AVALIACAO FINAL da disciplina "Gestao de Dados e Graficos no R", Gustavo Paterno e Carlos Fonseca, 2019
# LARA LOPES
# Last update: 2019-10-31

# A felicidade humana e influenciada pela renda per capita e pelo nível de direitos sociais do seu pais?
#h1: O PIB do país influencia o nivel de felicidade da população.
#h2: O cumprimento de direitos humanos do país influencia o nivel de felicidade da população.
# h3: O efeito do cumprimento de direitos humanos sobre o nivel de felicidade da populacao varia com o PIB.

# Script para AED das variaveis

# Load packages -----------------------------------------------------
library(ggplot2)
library(tidyverse)
library(cowplot)
library(sjPlot)

# Load data --------------------------------------------------------

d <- read.csv("data/processed/02_processed_sum_hapiness_PIB_rights_data.csv")

# Cores ------------------------------------------------------------

theme_lara <- theme(
  panel.grid.major.y = element_line(color = "gray93", linetype = 2, size = .5),
  axis.line = element_line(size = .75))

# Cores
# Color brewer pallete Set2
# scale_fill_manual(values = c("#66c2a5", "#fc8d62", "#8da0cb"))

# 1. Statistical dsitribution of variables --------------------------

str(d)
head(d)
var_stats <-
  data.frame(
    var = c("PIB", "PIB[log]", "Indice_Satisfacao", "Escore_D_Humano"),
    avg      = round(c(mean(d$PIB), mean(d$PIB_log), mean(d$felic_pais), mean(d$direito_h)), digits = 1),
    sd       = round(c(sd(d$PIB), sd(d$PIB_log), sd(d$felic_pais), sd(d$direito_h)), digits = 1),
    min      = c(min(d$PIB), min(d$PIB_log), min(d$felic_pais), min(d$direito_h)),
    max      = c(max(d$PIB), max(d$PIB_log), max(d$felic_pais), max(d$direito_h))
  )
var_stats

# 2. Distribuicao de variaveis numericas ---------------------------

# 2.1.1 PIB  ------

g1 <-
  ggplot(d, aes(x = PIB)) +
  geom_histogram(fill = "#fc8d62", color = "white") +
  theme_classic(base_size = 18) +
  labs(x = "PIB per capita (dolares internacionais)",
       y = "Frequência") +
  scale_x_continuous(labels = scales::comma) +
  theme_lara 

g1

# 2.1.1 PIB (log) ------

g2 <-
  ggplot(d, aes(x = log(PIB))) +
  geom_histogram(fill = "#fc8d62", color = "white") +
  theme_classic(base_size = 18) +
  labs(x = "PIB per capita (dolares internacionais)[log]",
       y = "Frequência") +
  scale_x_continuous(labels = scales::comma) +
  theme_lara

g2
 
# 2.2 Indice de Felicidade -----

g3 <-
  ggplot(d, aes(x = felic_pais)) +
  geom_histogram(fill = "#66c2a5", color = "white") +
  theme_classic(base_size = 18) +
  labs(x = "Índice de Satisfação",
       y = "Frequência") +
  scale_x_continuous(labels = scales::comma) +
  theme_lara

g3

# 2.2 Indice de Direitos Humanos -----

g4 <-
  ggplot(d, aes(x = direito_h)) +
  geom_histogram(fill = "#8da0cb", color = "white") +
  theme_classic(base_size = 18) +
  labs(x = "Escore de Direitos Humanos",
       y = "Frequência") +
  scale_x_continuous(labels = scales::comma) +
  theme_lara 
g4

# 3. Juntando plots -----

# align vertical and horizontal axis
# Align by the lefth margin (axis = "l")

gall <- cowplot::plot_grid(g1, g2, g3, g4, labels = c("A", "B", "C", "D"), 
                  align = "hv", axis = "l")
gall

# 5. Export table---------------
write.csv(x = var_stats, file = "output/supp/Sup_tab_descripive_stats_study_variables.csv", 
          row.names = FALSE)

# 6. Export figure---------------

ggplot2::ggsave(filename = "output/supp/Sup_fig_exploratory_analysis_variables_hapiness.png",
       plot = gall, 
       width = 12, 
       height = 8)

# tabela descritiva organizada
sjPlot::tab_df(var_stats, sort.column = 1, show.rownames = T, footnote = " var 1 = Escore de Direitos Humanos; var 2 = Indice de Satisfacao Pessoal; var 3 = PIB per capita", show.footnote = T)

