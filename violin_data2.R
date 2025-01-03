# Instalar e carregar pacotes necessários
if (!require("readxl")) install.packages("readxl", dependencies = TRUE)
if (!require("ggplot2")) install.packages("ggplot2", dependencies = TRUE)
if (!require("patchwork")) install.packages("patchwork", dependencies = TRUE)

library(readxl)
library(ggplot2)
library(patchwork)

# Ler o arquivo Excel
dados <- read_excel("violin2.xlsx")

# Converter os dados para formato longo para facilitar o uso no ggplot2
install.packages("tidyr")
library(tidyr)
dados_long <- pivot_longer(dados, cols = -id, names_to = "categoria", values_to = "valor")

# Criar gráficos para cada categoria
graficos <- lapply(unique(dados_long$categoria), function(cat) {
  dados_cat <- dados_long[dados_long$categoria == cat, ]
  top_outliers <- dados_cat[order(-dados_cat$valor), ][1:5, ]
  
  ggplot(dados_cat, aes(x = categoria, y = valor)) +
    geom_violin(trim = FALSE, fill = "lightblue", alpha = 0.5) +
    geom_jitter(aes(color = id), width = 0.2, size = 2) +
    geom_text(data = top_outliers, aes(label = id), vjust = -0.5, color = "red", size = 3) +
    labs(title = NULL, x = NULL, y = "Tonnes of CO2e/US$ Million") +
    theme_minimal() +
    theme(legend.position = "none")
})

# Combinar gráficos lado a lado
layout <- wrap_plots(graficos, ncol = 6) +
  plot_annotation(title = "(b) Pig iron and ferroalloys")

# Exibir os gráficos
print(layout)

