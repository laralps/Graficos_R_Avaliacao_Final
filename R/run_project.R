###### AVALIACAO FINAL da disciplina "Gestao de Dados e Graficos no R", Gustavo Paterno e Carlos Fonseca, 2019
# LARA LOPES
# Last update: 2019-10-31

# A felicidade humana e influenciada pela renda per capita e pelo nível de direitos sociais do seu pais?
#h1: O PIB do país influencia o nivel de felicidade da população.
#h2: O cumprimento de direitos humanos do país influencia o nivel de felicidade da população.
# h3: O efeito do cumprimento de direitos humanos sobre o nivel de felicidade da populacao varia com o PIB.

# Script para rodar o projeto completo
  # Nota: Reinicie a sessão do R antes de rodar esse script

# Start----
# 1. Run all scripts again on a fresh R section---------------------------------
# 1.1 Importe e limpe os dados --------------------------------------
source(file = "R/01_C_load_clean_hapiness.R") # ERRO

# 1.2 Analise exploratoria e imagens suplementares ------------------
source(file = "R/01_report_exploratory_analysis_hapiness.R")

# 1.3 Analise estatistica -------------------------------------------
source(file = "R/01_D_linear_regression_hapiness.R")

# 1.3 Plotando figuras ----------------------------------------------
source(file = "R/01_S_fig_linear_regression_hapiness.R")
