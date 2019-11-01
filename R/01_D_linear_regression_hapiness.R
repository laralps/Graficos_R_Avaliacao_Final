###### AVALIACAO FINAL da disciplina "Gestao de Dados e Graficos no R", Gustavo Paterno e Carlos Fonseca, 2019
# LARA LOPES
# Last update: 2019-10-31

# A felicidade humana e influenciada pela renda per capita e pelo nível de direitos sociais do seu pais?
#h1: O PIB do país influencia o nivel de felicidade da população.
#h2: O cumprimento de direitos humanos do país influencia o nivel de felicidade da população.
# h3: O efeito do cumprimento de direitos humanos sobre o nivel de felicidade da populacao varia com o PIB.

# Script para regressao linear 
  # felic_pais ~ direito_h * PIB
    # felic_pais ~ PIB
    # felic_pais ~ direito_h

# Start----
# Packages ----------------------------------------------------------------
library(tidyverse)
library(sjPlot)
library(cowplot)

# Load data ---------------------------------------------------------------
dat <- read.csv(file = "data/processed/02_processed_sum_hapiness_PIB_rights_data.csv")

# Check variable classes
str(dat)

# 1. Fit Linear Regression Model model------------------------------- 
# correlacao do indice de felicidade com o PIB
cor(x = dat$PIB, y = dat$felic_pais, method = "pearson") # .73

# correlacao do indice de felicidade com o indice de direitos humanos
cor(x = dat$direito_h, y = dat$felic_pais, method = "pearson") # .57

# Testando Regressoes 
  # direitos humanos
mod1 <- lm(felic_pais ~ direito_h, data = dat)
summary(mod1)
anova(mod1)
plot(mod1$residuals)
  # PIB per capita
mod2 <- lm(felic_pais ~ PIB, data = dat)
summary(mod2)
anova(mod2)
plot(mod2$residuals)

  # Direitos Humanos e PIB com interacao
mod3 <- lm(felic_pais ~ direito_h * PIB, data = dat)
summary(mod3)
anova(mod3)
plot(mod3$residuals)

sjPlot::tab_model(mod1)
sjPlot::tab_model(mod2)
sjPlot::tab_model(mod3)

### Conferindo o fit dos modelos

diag_mod3 <- plot_model(mod3, type = "diag")
d1<- diag_mod3[[1]] +
  theme_classic(base_size = 18)
d2<- diag_mod3[[2]] +
  theme_classic(base_size = 18)
d3 <- diag_mod3[[3]] +
  theme_classic(base_size = 18)
d4 <- diag_mod3[[4]] +
  theme_classic(base_size = 18) 

d_all <- cowplot::plot_grid(d1, d2, d3, d4, labels = c("A", "B", "C", "D"), align = "hv", axis = "l")
d_all

# 2. Format tables --------------------------------------------------

sum_table_mod3 <- broom::tidy(summary(mod3))
sum_table_mod3

ano_table_mod3 <- broom::tidy(anova(mod3))
ano_table_mod3

# 3. Save tables ----------------------------------------------------

write.csv(x = sum_table_mod3, 
          file = "output/tables/01_tab_summary_linear_regression_hapiness.csv",
          row.names = FALSE)
write.csv(x = ano_table_mod3, 
          file = "output/tables/01_tab_anova_linear_regression_hapiness.csv",
          row.names = FALSE)

# 3. Save diagnostic plot -------------------------------------------

ggplot2::ggsave(filename = "output/supp/Sup_fig_diag_plot_linear_model_hapiness.png",
                plot = d_all, 
                width = 12, 
                height = 8)

# 4. Save model object----------------------------------------------------------
saveRDS(object = mod3, file = "output/temp/temp_linear_regression_hapiness_mod3.Rds")

# END----