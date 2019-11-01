# Graficos_R_Avaliacao_Final

Projeto para avaliação final da disciplina de Graficos no R e Gestão de Dados, ministrada por Gustavo Paterno e Carlos Fonseca em 2019-10-21 a 2019-11-01.

## Autora

Lara Lopes (lara.cunhalopes@gmail.com, 20191013584)

Versão 2019-10-31
 
## Informações Gerais

**Título**: Dinheiro e direitos afetam a nossa felicidade?

### Objetivo ou hipóteses

**Objetivo:** Avaliar se a felicidade humana é influenciada pela renda per capita e pelo nível de direitos sociais do pais de habitação.

- H1: O PIB do país influencia o nível de felicidade da população.

- H2: O cumprimento de direitos humanos do país influencia o nível de felicidade da população.

- H3: O efeito do cumprimento de direitos humanos sobre o nível de felicidade da população varia com o PIB.

## Dados e Arquivos

- Graficos_R_Avaliacao_Final/
	 | --- data
		   | --- raw
				 gdp-vs-happiness.csv (dados bruto do PIB per capita e Indice de Satisfacao pessoal por pais e ano, erro colunas)
				 gdp-vs-happiness2.xlsx (dados bruto do PIB per capita e Indice de Satisfacao pessoal por pais e ano, erro corrigido)
				 human-rights-scores.csv (dados bruto do Escore de direitos sociais por pais e por ano)
		   | --- processed
			     01_processed_hapiness_PIB_rights_data.csv (planilha de dados processados por ano e pais)
				 02_processed_sum_hapiness_PIB_rights_data.csv (planilha de dados processados e sumarizados pelo pais, com media dos anos)
		   | --- temp
	 | --- output
		   | --- figures
				 Fig_01_linear_regression_mult_coef_hapiness.png 
				 Fig_01_linear_regression_mult_coef_hapiness.pdf 
				 Fig_02_linear_regression_parcial_hapiness.png
				 Fig_02_linear_regression_parcial_hapiness.pdf
		   | --- tables
				 01_tab_summary_linear_regression_hapiness.csv
				 02_tab_anova_linear_regression_hapiness.csv
		   | --- supp
				 Sup_fig_diag_plot_linear_model_hapiness.png
				 Sup_fig_exploratory_analysis_variables_hapiness.png
				 Sup_tab_descripive_stats_study_variables.csv
		   | --- temp	 
				 temp_linear_regression_hapiness_mod3
	 | --- R
		   01_C_load_clean_hapiness.R (script do processamento dos dados brutos em dados limpos)
		   01_D_linear_regression_hapiness.R (análise estatística dos dados limpos)
		   01_report_exploratory_analysis_hapiness.R (script da análise exploratória dos dados limpos)
		   01_S_fig_linear_regression_hapiness.R (script para figuras das analises estatisticas)
		   run_project.R (script para rodar o projeto inteiro)
	 | --- docs
	 .Rhistory
	 Graficos_R_Avaliacao_Final.Rproj
	 README.md
	 
 ### Fonte de Dados

Dados brutos foram coletados a partir do Our World in Data, nos seguintes acessos:
	- Felicidade e renda per capita: https://ourworldindata.org/happiness-and-life-satisfaction 
Gapminder, HYDE (2016) and United Nations Population Division (2019)
	- Direitos Humanos: https://ourworldindata.org/human-rights 
Schnakenberg, K. E. & Fariss, C. J. (2014). Dynamic Patterns of Human Rights Practices. Political Science Research and Methods, 2(1), 1–31. doi:10.1017/psrm.2013.15 Fariss, C. J. (2019). Yes, Human Rights Practices Are Improving Over Time. American Political Science Review. Advance online publication. doi: 10.1017/S000305541900025X

## Informações metodológicas

### Lista e Descrição de Variáveis

|       VARIÁVEIS  | DESCRIÇÃO     	    | UNIDADE		|  
|----------------|---------------------|----------------|
|Pais | Países em que foram medidas as variáveis de interesse. | sem unidade |	    
|ano | Anos em que foram amostrados as variáveis de interesse. O dado bruto tem como escala temporal 10000 BCE – 2019. Foi utilizada a escala de 1990 a 2019. | ano |	    
|PIB | PIB per capita com base na paridade do poder de compra (PPP), que significa o produto interno bruto convertido em dólares internacionais usando taxas de paridade do poder de compra. Um dólar internacional tem o mesmo poder de compra sobre o PIB que o dólar americano nos Estados Unidos. O PIB a preços de compra é a soma do valor agregado bruto de todos os produtores residentes na economia, mais quaisquer impostos sobre produtos e menos quaisquer subsídios não incluídos no valor dos produtos. É calculado sem deduções para depreciação de ativos fabricados ou para esgotamento e degradação de recursos naturais. Os dados estão em dólares internacionais constantes de 2011. | dolar |	    
|felic_pais | Média de respostas à pergunta 'Cantril Ladder' na Pesquisa Gallup World. A pesquisa pede aos entrevistados que pensem em uma escala, com a melhor vida possível para eles sendo um 10 e a pior vida possível sendo um 0. | sem unidade |
|direito_h |  Um escore de proteção aos Direitos Humanos desenvolvida por Schnakenberg e Farris (2014) e posteriormente atualizada por Farris (2019). O escore têm valores entre -3,8 e 5,4 e quanto maior, melhor. | sem unidade |

Obs: Nos dados processados utilizamos a média de todos os anos para as variáveis PIB, felic_pais e direito_h.

### Número de Observações

	155 observações.

# Acesso e Utilização

Baixe o repositório [aqui](https://github.com/laralps/Graficos_R_Avaliacao_Final.git}, unzipe e rode o Projeto "Graficos_R_Avaliacao_Final".



