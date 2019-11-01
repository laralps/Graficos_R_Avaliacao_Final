###### AVALIACAO FINAL da disciplina "Gestao de Dados e Graficos no R", Gustavo Paterno e Carlos Fonseca, 2019
# LARA LOPES
# Last update: 2019-10-31

# A felicidade humana e influenciada pela renda per capita e pelo cumprimento dos direitos sociais do seu pais?
#h1: O PIB do país influencia o nivel de felicidade da população.
#h2: O cumprimento de direitos humanos do país influencia o nivel de felicidade da população.
# h3: O efeito do cumprimento de direitos humanos sobre o nivel de felicidade da populacao varia com o PIB.

# Script para plotar regressao linear -----------------------------
  
# felic_pais ~ direito_h * PIB

# Start----
# Packages ---------------------------------------------------------

library(tidyverse)
library(ggpubr)
library(sjPlot)
library(cowplot)

# Load data ---------------------------------------------------------------
dat <- read.csv(file = "data/processed/02_processed_sum_hapiness_PIB_rights_data.csv")

# Check variable classes
str(dat)

# Plot Reg Multipla ----

mod3 <- glm(felic_pais ~ direito_h * PIB, data = dat)

# definindo tema 
theme_lara <- theme(panel.background = element_rect(fill = "white"),
  panel.grid.major.y = element_line(color = "gray93", linetype = 2, size = .5),
  axis.line = element_line(size = .75))

# coefficient plot automatico

f1 <- plot_model(mod3, show.values = TRUE, colors = c("#fc8d62","#8da0cb"), line.size = 1.05, value.size = 4, dot.size = 4, ) + 
  geom_hline(yintercept = 0) + # add reta do 0 
  theme_classic(base_size = 18) +
  theme_lara + 
  labs(title = "Índice de Satisfação",
                    y = "Estimate",
                    x = "Model term")
f1

# 1. Plot Linear regression -----
# felic_pais ~ PIB
f2 <- ggplot(dat, aes(y = felic_pais, x = PIB, fill = pais)) +
  geom_point(shape = 21, size = 4, color = "black", alpha = .5) +
  geom_smooth(method = glm, fill = "gray", color = "black") +
  stat_cor(label.x = 5, size = 6) +
  stat_regline_equation(label.x = 5, label.y = 9, size = 6) +
  theme_classic(base_size = 18) +
  theme_lara +
  theme(legend.position = "none") +
  labs(y = "Índice de Satisfação", x = "PIB per Capita") +
  annotate("text",
           size = 4,
           x = 20000,
           y = 11,
           label = "italic(Y) == {4.65 - 0.00 * x}",
           parse = TRUE)
f2

# felic_pais ~ direito_h

f3 <- ggplot(dat, aes(y = felic_pais, x = direito_h, fill = pais)) +
  geom_point(shape = 21, size = 4, color = "black", alpha = .5) +
  geom_smooth(method = lm, fill = "gray", color = "black") +
  stat_cor(label.x = 5, size = 6) +
  stat_regline_equation(label.x = 5, label.y = 9, size = 6) +
  theme_classic(base_size = 18) +
  theme_lara +
  theme(legend.position = "none") +
    labs(y = "Índice de Satisfação",
         x = "Escore de Direitos Humanos") + 
  annotate("text",
           size = 4,
           x = -1.5,
           y = 8,
           label = "italic(Y) == {5.24 - 0.43 * x}",
           parse = TRUE)
f3
# Juntando Regressoes Lineares parciais
f2_f3 <- cowplot::plot_grid(f2, f3, labels = c("A", "B"), 
                           align = "hv", axis = "l", nrow = 1, ncol = 2)
f2_f3


# 2. Save plot-----
# Regressao Multipla - plot de coeficientes
  # png
ggsave(plot = f1, 
       filename = "output/figures/Fig_01_linear_regression_mult_coef_hapiness.png", 
       width = 6, height = 4)
  # pdf
ggsave(plot = f1, 
       filename = "output/figures/Fig_01_linear_regression_mult_coef_hapiness.pdf", 
       width = 6, height = 4)

# Regressao Linear parcial - felic_pais ~ PIB / felic_pais ~ direito_h
# png
ggsave(plot = f2_f3, 
       filename = "output/figures/Fig_02_linear_regression_parcial_hapiness.pdf", 
       width = 8, height = 4)
# pdf
ggsave(plot = f2_f3, 
       filename = "output/figures/Fig_02_linear_regression_parcial_hapiness.png", 
       width = 8, height = 4)

# END----