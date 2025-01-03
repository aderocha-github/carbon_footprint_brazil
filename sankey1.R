# Instalação dos pacotes
install.packages("networkD3")
install.packages("readxl")

# Carregamento dos pacotes
library(networkD3)
library(readxl)

# Leitura dos dados
links2 <- read_xlsx("C:/Users/Ademir Rocha/Desktop/R_plot/sankey1.xlsx", sheet = "links")
nodes2 <- read_xlsx("C:/Users/Ademir Rocha/Desktop/R_plot/sankey1.xlsx", sheet = "nodes")

# Criando o gráfico Sankey com cor azul
sankey <- sankeyNetwork(
  Links = links2, 
  Nodes = nodes2, 
  Source = "source",
  Target = "target", 
  Value = "value", 
  NodeID = "name",
  fontFamily = "sans-serif", 
  iterations = 0,
  colourScale = JS("d3.scaleOrdinal().range(['#99CCFF']);"), fontSize = 10)  # Define a cor azul

# Adicionando o texto simples acima do gráfico
sankey <- htmlwidgets::onRender(
  sankey,
  "
  function(el, x) {
    var svg = d3.select(el).select('svg');
    var width = svg.attr('width');
    var height = svg.attr('height');
    
    // Texto acima do gráfico
    svg.append('text')
      .attr('x', 25)  // Posição horizontal central
      .attr('y', 4)  // Posição vertical acima do gráfico
      .attr('text-anchor', 'right')  // Centraliza o texto
      .attr('font-size', '15px')
      .attr('font-family', 'sans-serif')
      .attr('fill', '#000000')  // Cor do texto
      .text('');
  }
  "
)

# Exibe o gráfico
sankey





