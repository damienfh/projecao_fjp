#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/

library(plotly)
library(shiny)
library(ggplot2)
library(dplyr)
library(readxl)
library(readr)
library(tidyverse)
library(bslib)
library(highcharter)
library(shinydashboard)
library(fresh)
library(openxlsx)
library(curl)
library(readxl)
library(XML)
# 
# base_pop_idade_mn_vg <- read_excel("data/base_pop_idade_mn_vg.xlsx")
# base_pop_idade_porte_vg <- read_excel("data/base_pop_idade_porte_vg.xlsx")
# base_pop_idade_rg_vg <- read_excel("data/base_pop_idade_rg_vg.xlsx")
# base_pop_idade_mn_sexo_vg <- read_excel("data/base_pop_idade_mn_sexo_vg.xlsx")
# base_pop_idade_porte_sexo_vg <- read_excel("data/base_pop_idade_porte_sexo_vg.xlsx")
# base_pop_idade_rg_sexo_vg <- read_excel("data/base_pop_idade_rg_sexo_vg.xlsx")
# 
# pop_minas_gerais <- read_excel("data/pop_minas_gerais.xlsx")
# pop_minas_gerais_sexo <- read_excel("data/pop_minas_gerais_sexo.xlsx")
# 
# # 2- PIRÂMIDES
# 
# # pop_interp_mm_idade_shiny <- read_excel("pop_interp_mm_idade_shiny.xlsx")
# pop_interp_mm_idade_shiny_proj <- read_excel("data/pop_interp_mm_idade_shiny_proj.xlsx")
# 
# # 3- RS E TX CRESCIMENTO
# 
# rs_mn = read_excel("data/rs_mn.xlsx")
# rs_porte = read_excel("data/rs_porte.xlsx")
# rs_rg = read_excel("data/rs_rg.xlsx")
# 
# base_tx_mn_total <- read_excel("data/base_tx_mn_total.xlsx")
# base_tx_porte_total <- read_excel("data/base_tx_porte_total.xlsx")
# base_tx_rg_total <- read_excel("data/base_tx_rg_total.xlsx")
# 
# # 4- CRESCIMENTO POR IDADE
# 
# base_pop_idade_mn <- read_excel("data/base_pop_idade_mn.xlsx")
# base_pop_idade_rg <- read_excel("data/base_pop_idade_rg.xlsx")
# base_pop_idade_porte <- read_excel("data/base_pop_idade_porte.xlsx")
# 
# base_pop_idade_mn_total <- read_excel("data/base_pop_idade_mn_total.xlsx")
# base_pop_idade_porte_total <- read_excel("data/base_pop_idade_porte_total.xlsx")
# base_pop_idade_rg_total <- read_excel("data/base_pop_idade_rg_total.xlsx")
# 
# # 5- RDP
# 
# razao_dep_jovem_mn <- read_excel("data/razao_dep_jovem_mn.xlsx")
# razao_dep_idosa_mn <- read_excel("data/razao_dep_idosa_mn.xlsx")
# razao_dep_total_mn <- read_excel("data/razao_dep_total_mn.xlsx")
# 
# razao_dep_jovem_rg <- read_excel("data/razao_dep_jovem_rg.xlsx")
# razao_dep_idosa_rg <- read_excel("data/razao_dep_idosa_rg.xlsx")
# razao_dep_total_rg <- read_excel("data/razao_dep_total_rg.xlsx")
# 
# razao_dep_jovem_porte <- read_excel("data/razao_dep_jovem_porte.xlsx")
# razao_dep_idosa_porte <- read_excel("data/razao_dep_idosa_porte.xlsx")
# razao_dep_total_porte <- read_excel("data/razao_dep_total_porte.xlsx")
# 
# # 5- I.E e PERCENTUAIS
# 
# indice_de_envelhecimento_mn_60 <- read_excel("data/indice_de_envelhecimento_mn_60.xlsx")
# indice_de_envelhecimento_mn_65 <- read_excel("data/indice_de_envelhecimento_mn_65.xlsx")
# indice_de_envelhecimento_mn_80 <- read_excel("data/indice_de_envelhecimento_mn_80.xlsx")
# 
# indice_de_envelhecimento_porte_60 <- read_excel("data/indice_de_envelhecimento_porte_60.xlsx")
# indice_de_envelhecimento_porte_65 <- read_excel("data/indice_de_envelhecimento_porte_65.xlsx")
# indice_de_envelhecimento_porte_80 <- read_excel("data/indice_de_envelhecimento_porte_80.xlsx")
# 
# indice_de_envelhecimento_rg_60 <- read_excel("data/indice_de_envelhecimento_rg_60.xlsx")
# indice_de_envelhecimento_rg_65 <- read_excel("data/indice_de_envelhecimento_rg_65.xlsx")
# indice_de_envelhecimento_rg_80 <- read_excel("data/indice_de_envelhecimento_rg_80.xlsx")
# 
# percentual_maior_de_60_anos_mn <- read_excel("data/percentual_maior_de_60_anos_mn.xlsx")
# percentual_maior_de_60_anos_porte <- read_excel("data/percentual_maior_de_60_anos_porte.xlsx")
# percentual_maior_de_60_anos_rg <- read_excel("data/percentual_maior_de_60_anos_rg.xlsx")
# 
# percentual_maior_de_65_anos_mn <- read_excel("data/percentual_maior_de_65_anos_mn.xlsx")
# percentual_maior_de_65_anos_porte <- read_excel("data/percentual_maior_de_65_anos_porte.xlsx")
# percentual_maior_de_65_anos_rg <- read_excel("data/percentual_maior_de_65_anos_rg.xlsx")
# 
# percentual_menor_de_5_anos_mn <- read_excel("data/percentual_menor_de_5_anos_mn.xlsx")
# percentual_menor_de_5_anos_porte <- read_excel("data/percentual_menor_de_5_anos_porte.xlsx")
# percentual_menor_de_5_anos_rg <- read_excel("data/percentual_menor_de_5_anos_rg.xlsx")

# Exportar

export <- list(
  list(text="PNG",
       onclick=JS("function () {
                this.exportChartLocal(); }")),
  list(text="JPEG",
       onclick=JS("function () {
                this.exportChartLocal({ type: 'image/jpeg' }); }"))
)

# Criar um tema personalizado
custom_theme <- create_theme(
  adminlte_color(
    light_blue = "#0080FF",  # Cor para o cabeçalho e barra lateral
    green = "#28a745",       # Cor dos botões e notificações
    red = "#dc3545"          # Cor de alertas ou destaques
  ),
  adminlte_sidebar(
    dark_bg = "#343a40",     # Cor de fundo da barra lateral
    dark_hover_bg = "#495057", # Cor ao passar o mouse nos itens da barra lateral
    dark_color = "#ffffff"   # Cor do texto da barra lateral
  ),
  adminlte_global(
    content_bg = "#f8f9fa",  # Cor de fundo do corpo do aplicativo
    box_bg = "#ffffff",      # Cor de fundo das caixas
    info_box_bg = "#e9ecef"  # Cor de fundo das info-boxes
  )
)

# UI

ui <-  dashboardPage(
  dashboardHeader(title = "Projeções FJP",
                  titleWidth = 540),
  dashboardSidebar(sidebarMenu(id = 'barra_lateral',
                               menuItem("Início", tabName = 'opcao0'),
                               menuItem(" - População", tabName = 'opcao01', icon = icon("1")),
                               menuItem(" - Taxa de crescimento", tabName = 'opcao011', icon = icon("2")),
                               menuItem(" - Pirâmide etária", tabName = 'opcao1', icon = icon("3")),
                               menuItem(" - Razão de dependência", tabName = 'opcao2', icon = icon("4")),
                               menuItem(" - População por grupo etário", tabName = 'opcao111', icon = icon("5")),
                               menuItem(" - Percentuais", tabName = 'opcao03', icon = icon("6")),
                               menuItem(" - Índice de envelhecimento", tabName = 'opcao3', icon = icon("7")),
                               menuItem(" - Razão de sexo", tabName = 'opcao110', icon = icon("8")),
                               menuItem("Equipe técnica", tabName = 'opcao4')
  )
  ),
  dashboardBody(
    use_theme(custom_theme),
    tabItems(
      
      # 1 - Introdução
      tabItem(
        tabName = 'opcao0',
        div(style = "display: flex; justify-content: space-evenly; align-items: center",
            img(src = "Nova-Marca-FJP-sem-fundo.png", height = 100, width = 110),
            img(src = "imagem_destaque_fapemig.png", height = 100, width = 120)),
        h1("Projeção Populacional dos Municípios de Minas Gerais (2022-2047)", 
           style = "
           margin-top: 50px;
           font-family: 'Arial'; 
           font-size: 26px; 
           font-weight: bold; 
           color: #333;
           text-align: center;
           "),
        h2(HTML("<b>Data da publicação:</b> 20 de março de 2025"),
           style = "
           margin-top: 50px;
           font-family: 'Arial'; 
           font-size: 20px; 
           font-weight: normal; 
           color: #333;
           text-align: center;
           "),
        p("Este painel apresenta os resultados, em formato de gráficos, da 
          projeção populacional dos municípios de Minas Gerais para o período 
          de 2022 a 2047. Por meio das abas disponíveis no menu à esquerda, 
          é possível explorar diversos indicadores demográficos, organizados 
          por município, região intermediária e porte populacional. Em cada página,
          haverá sempre dois gráficos, com opção de filtragem dos dados logo acima,
          permitindo a comparação dos indicadores em diferentes níveis de análise.
          Esses indicadores oferecem uma visão abrangente das tendências 
          demográficas que moldarão o futuro dos municípios.", 
          style = "
          font-family: 'Arial'; 
          font-size: 20px; 
          font-weight: normal; 
          color: #333;
          text-align: justify;
          margin-top: 50px;
          "),
        p(HTML("<b>1. Visão Geral:</b> Apresenta o crescimento populacional absoluto, 
          desagregado por idade e sexo, proporcionando uma visão inicial da dinâmica populacional."), 
          style = "
          font-family: 'Arial'; 
          font-size: 18px; 
          font-weight: normal; 
          color: #333;
          text-align: justify;
          margin-top: 50px;
          "),
        p(HTML("<b>2. Taxas de crescimento:</b> Apresenta a taxa de crescimento populacional 
        entre períodos."), 
          style = "
          font-family: 'Arial'; 
          font-size: 18px; 
          font-weight: normal; 
          color: #333;
          text-align: justify;
          margin-top: 25px;
          "),
        p(HTML("<b>3. Pirâmides Etárias:</b> Exibe as pirâmides etárias, que ilustram a 
          distribuição da população por idade e sexo, permitindo uma análise visual da estrutura demográfica."), 
          style = "
          font-family: 'Arial'; 
          font-size: 18px; 
          font-weight: normal; 
          color: #333;
          text-align: justify;
          margin-top: 25px;
          "),
        p(HTML("<b>4. Razão de Dependência:</b> Apresenta a razão de dependência total, jovem e idosa, 
          que mede a proporção da população economicamente dependente (menores de 15 anos e maiores de 65 anos) 
          em relação à população em idade ativa (15 a 64 anos)."), 
          style = "
          font-family: 'Arial'; 
          font-size: 18px; 
          font-weight: normal; 
          color: #333;
          text-align: justify;
          margin-top: 25px;
          "),
        p(HTML("<b>5. Crescimento por Idade:</b> Detalha o crescimento absoluto da população em três faixas etárias: 0 a 14 anos, 
          15 a 60 anos e 60 anos ou mais, evidenciando as tendências de envelhecimento e rejuvenescimento populacional."), 
          style = "
          font-family: 'Arial'; 
          font-size: 18px; 
          font-weight: normal; 
          color: #333;
          text-align: justify;
          margin-top: 25px;
          "),
        p(HTML("<b>6. Percentuais:</b> Inclui o crescimento absoluto do percentual 
          da população com 60 e 65 anos ou mais, bem como da população com menos de 5 anos, fornecendo insights 
          adicionais sobre as transformações demográficas em curso."), 
          style = "
          font-family: 'Arial'; 
          font-size: 18px; 
          font-weight: normal; 
          color: #333;
          text-align: justify;
          margin-top: 25px;
          "),
        p(HTML("<b>7. Índice de envelhecimento:</b> Inclui o índice de envelhecimento."), 
          style = "
          font-family: 'Arial'; 
          font-size: 18px; 
          font-weight: normal; 
          color: #333;
          text-align: justify;
          margin-top: 25px;
          "),
        p(HTML("<b>8. Razão de Sexo:</b> Oferece dados sobre a razão de sexo (proporção entre homens e mulheres) 
          por grupo etário."), 
          style = "
          font-family: 'Arial'; 
          font-size: 18px; 
          font-weight: normal; 
          color: #333;
          text-align: justify;
          margin-top: 25px;
          "),
        p("Esses indicadores são essenciais para o planejamento de políticas públicas e 
          estratégias de desenvolvimento, permitindo uma compreensão aprofundada das mudanças 
          populacionais que afetarão Minas Gerais nas próximas décadas.", 
          style = "
          font-family: 'Arial'; 
          font-size: 18px; 
          font-weight: normal; 
          color: #333;
          text-align: justify;
          margin-top: 25px;
          "),
        p("Para acessar o relatório e a base de dados completa, acesse: ",
          a("https://fjp.mg.gov.br/estudos-populacionais/", 
            href = "https://fjp.mg.gov.br/estudos-populacionais/", 
            target = "_blank"), 
          style = "
          font-family: 'Arial'; 
          font-size: 18px; 
          font-weight: normal; 
          color: #333;
          text-align: justify;
          margin-top: 25px;
          "),
        p("Dúvidas, entre em contato pelo e-mail: ",
          a("dados@fjp.mg.gov.br", 
            href = "mailto:dados@fjp.mg.gov.br"), 
          style = "
          font-family: 'Arial'; 
          font-size: 18px; 
          font-weight: normal; 
          color: #333;
          text-align: justify;
          margin-top: 25px;
          ")
      ),
      
      # 2- Visão Geral
      tabItem(
        tabName = 'opcao01',
        
        h1("População de Minas Gerais total e por sexo", 
           style = "
     margin-top: 10px;
     font-family: 'Arial'; 
     font-size: 24px; 
     font-weight: bold; 
     color: #333;
     text-align: center;
     "),
        h2("Instruções: Selecione o nível de análise (Minas Gerais, Município, 
           Região intermediária ou Porte populacional), a unidade desejada, e escolha Total, 
           Homens e/ou Mulheres. Repita o mesmo processo no Gráfico 2 para realizar comparações.", 
           style = "
     margin-top: 10px;
     font-family: 'Arial'; 
     font-size: 15px; 
     font-weight: normal; 
     color: #333;
     text-align: center;
     "),
        
        # 🔹 Primeira linha: Caixas de filtros lado a lado
        fluidRow(
          # Caixa de filtros para o Gráfico 1
          box(
            width = 6, 
            title = "Opções de filtro para o Gráfico 1",
            solidHeader = TRUE, 
            status = "primary", 
            collapsible = TRUE, 
            collapsed = FALSE,
            fluidRow(
              column(width = 4,  # Coluna para "Escolha o nível de análise"
                     selectInput(inputId = 'nivel_analise1',
                                 label = "Selecione o nível de análise:",
                                 choices = c("Minas Gerais" = "MG",
                                             "Município" = "nome_mn",
                                             "Região intermediária" = "nome_rg",
                                             "Porte populacional" = "portepop"))
              ),
              column(width = 4,  # Coluna para o filtro dinâmico
                     uiOutput("filtroUnidade1")
              ),
              column(width = 4,  # Coluna para "Escolha o sexo"
                     selectInput(inputId = 'sexo1',
                                 label = "Selecione o sexo:",
                                 choices = c("Total", "Homens", "Mulheres"),
                                 selected = c("Total", "Homens", "Mulheres"),
                                 multiple = TRUE)
              )
            )
          ),
          
          # Caixa de filtros para o Gráfico 2
          box(
            width = 6, 
            title = "Opções de filtro para o Gráfico 2",
            solidHeader = TRUE, 
            status = "primary", 
            collapsible = TRUE, 
            collapsed = FALSE,
            fluidRow(
              column(width = 4,  # Coluna para "Escolha o nível de análise"
                     selectInput(inputId = 'nivel_analise2',
                                 label = "Selecione o nível de análise:",
                                 choices = c("Minas Gerais" = "MG",
                                             "Município" = "nome_mn",
                                             "Região intermediária" = "nome_rg",
                                             "Porte populacional" = "portepop"))
              ),
              column(width = 4,  # Coluna para o filtro dinâmico
                     uiOutput("filtroUnidade2")
              ),
              column(width = 4,  # Coluna para "Escolha o sexo"
                     selectInput(inputId = 'sexo2',
                                 label = "Selecione o sexo:",
                                 choices = c("Total", "Homens", "Mulheres"),
                                 selected = c("Total", "Homens", "Mulheres"),
                                 multiple = TRUE)
              )
            )
          )
        ),
        
        # 🔹 Segunda linha: Caixas dos gráficos diretamente abaixo dos filtros
        fluidRow(
          # Gráfico 1
          box(
            width = 6, 
            title = "Gráfico 1",
            solidHeader = TRUE,
            status = "info",
            collapsible = TRUE,
            highchartOutput(outputId = 'grafico1', height = "500px")
          ),
          
          # Gráfico 2
          box(
            width = 6, 
            title = "Gráfico 2",
            solidHeader = TRUE,
            status = "info",
            collapsible = TRUE,
            highchartOutput(outputId = 'grafico2', height = "500px")
          )
        )
      ),
      
      # TAXA DE CRESCIMENTO
      
      tabItem(
        tabName = 'opcao011', 
        
        h1("Taxas de crescimento populacional de Minas Gerais", 
           style = "
     margin-top: 10px;
     font-family: 'Arial'; 
     font-size: 24px; 
     font-weight: bold; 
     color: #333;
     text-align: center;
     "),
        h2("Instruções: Selecione o nível de análise (Município, 
     Região intermediária e Porte populacional) e a unidade desejada. Repita o 
     mesmo processo no Gráfico 2 para realizar comparações.", 
           style = "
     margin-top: 10px;
     font-family: 'Arial'; 
     font-size: 15px; 
     font-weight: normal; 
     color: #333;
     text-align: center;
     "),
        
        # 🔹 Primeira linha: Caixas de filtros lado a lado
        fluidRow(
          # Caixa de filtros para o Gráfico 1 (Taxa de Crescimento)
          box(
            width = 6, 
            title = "Opções de filtro para Gráfico 1",
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            collapsed = FALSE,
            fluidRow(
              column(width = 4,
                     selectInput("escala_taxa011_1", "Selecione o nível de análise:",
                                 choices = c(
                                   "Município" = "nome_mn",
                                   "Região Intermediária" = "nome_rg",
                                   "Porte Populacional" = "portepop"
                                 )
                     )
              ),
              column(width = 4,
                     uiOutput("filtroEscalaTaxa011_1") # Filtro dinâmico
              )
            )
          ),
          
          # Caixa de filtros para o Gráfico 2 (Taxa de Crescimento)
          box(
            width = 6, 
            title = "Opções de filtro para Gráfico 2",
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            collapsed = FALSE,
            fluidRow(
              column(width = 4,
                     selectInput("escala_taxa011_2", "Selecione o nível de análise:",
                                 choices = c(
                                   "Município" = "nome_mn",
                                   "Região Intermediária" = "nome_rg",
                                   "Porte Populacional" = "portepop"
                                 )
                     )
              ),
              column(width = 4,
                     uiOutput("filtroEscalaTaxa011_2") # Filtro dinâmico
              )
            )
          )
        ),
        
        # 🔹 Segunda linha: Caixas dos gráficos diretamente abaixo dos filtros
        fluidRow(
          # Gráfico 1 (Taxa de Crescimento)
          box(
            width = 6,
            title = "Gráfico 1",
            solidHeader = TRUE,
            status = "info",
            collapsible = TRUE,
            highchartOutput("grafico_taxa011_1", height = "500px")
          ),
          
          # Gráfico 2 (Taxa de Crescimento)
          box(
            width = 6,
            title = "Gráfico 2",
            solidHeader = TRUE,
            status = "info",
            collapsible = TRUE,
            highchartOutput("grafico_taxa011_2", height = "500px")
          )
        )
      ),
      
      # 3- Pirâmides
      tabItem(
        tabName = 'opcao1',
        
        h1("Pirâmides etárias da população de Minas Gerais",
           style = "
     margin-top: 10px;
     font-family: 'Arial';
     font-size: 24px;
     font-weight: bold;
     color: #333;
     text-align: center;
     "),
        h2("Instruções: Selecione o nível de análise (Minas Gerais, Município, 
           Região intermediária e Porte populacional), a unidade desejada e escolha o ano. 
           Repita o mesmo processo na Pirâmide etária 2 para realizar comparações.",
           style = "
     margin-top: 10px;
     font-family: 'Arial';
     font-size: 15px;
     font-weight: normal;
     color: #333;
     text-align: center;
     "),
        
        # 🔹 Primeira linha: Caixas de filtros lado a lado
        fluidRow(
          # Caixa de filtros para a pirâmide etária 1
          box(
            width = 6, 
            title = "Opções de filtro para a pirâmide etária 1",
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            collapsed = FALSE,
            fluidRow(
              column(width = 4,
                     selectInput("escala1", "Selecione o nível de análise:",
                                 choices = c(
                                   "Minas Gerais" = "MG",
                                   "Município" = "nome_mn",
                                   "Região Intermediária" = "nome_rg",
                                   "Porte Populacional" = "portepop"
                                 )
                     )
              ),
              column(width = 4,
                     uiOutput("filtroEscala1") # Filtro dinâmico
              ),
              column(width = 4,
                     selectInput("ano1", "Selecione o ano:",
                                 choices = c(2022, 2027, 2032, 2037, 2042, 2047))
              )
            )
          ),
          
          # Caixa de filtros para a pirâmide etária 2
          box(
            width = 6, 
            title = "Opções de filtro para a pirâmide etária 2",
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            collapsed = FALSE,
            fluidRow(
              column(width = 4,
                     selectInput("escala2", "Selecione o nível de análise:",
                                 choices = c(
                                   "Minas Gerais" = "MG",
                                   "Município" = "nome_mn",
                                   "Região Intermediária" = "nome_rg",
                                   "Porte Populacional" = "portepop"
                                 )
                     )
              ),
              column(width = 4,
                     uiOutput("filtroEscala2") # Filtro dinâmico
              ),
              column(width = 4,
                     selectInput("ano2", "Selecione o ano:",
                                 choices = c(2022, 2027, 2032, 2037, 2042, 2047))
              )
            )
          )
        ),
        
        # 🔹 Segunda linha: Caixas dos gráficos diretamente abaixo dos filtros
        fluidRow(
          # Pirâmide etária 1
          box(
            width = 6,
            title = "Pirâmide etária 1",
            solidHeader = TRUE,
            status = "info",
            collapsible = TRUE,
            highchartOutput("piramideEtaria1", height = "500px")
          ),
          
          # Pirâmide etária 2
          box(
            width = 6,
            title = "Pirâmide etária 2",
            solidHeader = TRUE,
            status = "info",
            collapsible = TRUE,
            highchartOutput("piramideEtaria2", height = "500px")
          )
        )
      ),
      
      # RS 
      tabItem(
        tabName = 'opcao110', 
        
        h1("Razão de sexo por grupo etário e taxas de crescimento populacional de Minas Gerais", 
           style = "
     margin-top: 10px;
     font-family: 'Arial'; 
     font-size: 24px; 
     font-weight: bold; 
     color: #333;
     text-align: center;
     "),
        h2("Instruções: Selecione o nível de análise (Município, 
     Região intermediária e Porte populacional), a unidade desejada e escolha ano.
     Repita o mesmo processo no Gráfico 2 para realizar comparações.", 
           style = "
     margin-top: 10px;
     font-family: 'Arial'; 
     font-size: 15px; 
     font-weight: normal; 
     color: #333;
     text-align: center;
     "),
        
        # 🔹 Primeira linha: Caixas de filtros lado a lado
        fluidRow(
          # Caixa de filtros para o Gráfico 1 (Razão de sexo)
          box(
            width = 6, 
            title = "Opções de filtro para Gráfico 1",
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            collapsed = FALSE,
            fluidRow(
              column(width = 4,
                     selectInput("escala_indicador110_1", "Selecione o nível de análise:",
                                 choices = c(
                                   "Município" = "nome_mn",
                                   "Região Intermediária" = "nome_rg",
                                   "Porte Populacional" = "id"
                                 )
                     )
              ),
              column(width = 4,
                     uiOutput("filtroEscalaIndicador110_1") # Filtro dinâmico
              ),
              column(width = 4,
                     selectInput("ano_indicador110_1", "Selecione o ano:",
                                 choices = c("2022", "2025", "2026", "2027", "2032", "2037", "2042", "2047"),
                                 selected = "2022")
              )
            )
          ),
          
          # Caixa de filtros para o Gráfico 2 (Razão de sexo)
          box(
            width = 6, 
            title = "Opções de filtro para Gráfico 2",
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            collapsed = FALSE,
            fluidRow(
              column(width = 4,
                     selectInput("escala_indicador110_2", "Selecione o nível de análise:",
                                 choices = c(
                                   "Município" = "nome_mn",
                                   "Região Intermediária" = "nome_rg",
                                   "Porte Populacional" = "id"
                                 )
                     )
              ),
              column(width = 4,
                     uiOutput("filtroEscalaIndicador110_2") # Filtro dinâmico
              ),
              column(width = 4,
                     selectInput("ano_indicador110_2", "Selecione o ano:",
                                 choices = c("2022", "2025", "2026", "2027", "2032", "2037", "2042", "2047"),
                                 selected = "2022")
              )
            )
          )
        ),
        
        # 🔹 Segunda linha: Caixas dos gráficos diretamente abaixo dos filtros
        fluidRow(
          # Gráfico 1 (Razão de sexo)
          box(
            width = 6,
            title = "Gráfico 1",
            solidHeader = TRUE,
            status = "info",
            collapsible = TRUE,
            highchartOutput("grafico_indicador110_1", height = "500px")
          ),
          
          # Gráfico 2 (Razão de sexo)
          box(
            width = 6,
            title = "Gráfico 2",
            solidHeader = TRUE,
            status = "info",
            collapsible = TRUE,
            highchartOutput("grafico_indicador110_2", height = "500px")
          )
        )
      ),
      
      # CRESCIMENTO POR IDADE
      
      tabItem(
        tabName = 'opcao111',
        
        h1("População de Minas Gerais por grupo etário", 
           style = "
     margin-top: 10px;
     font-family: 'Arial'; 
     font-size: 24px; 
     font-weight: bold; 
     color: #333;
     text-align: center;
     "),
        h2("Instruções: Selecione o nível de análise (Município, Região intermediária e 
           Porte populacional), a unidade desejada e escolha o grupo etário. Repita o 
           mesmo processo no Gráfico 2 para realizar comparações.", 
           style = "
     margin-top: 10px;
     font-family: 'Arial'; 
     font-size: 15px; 
     font-weight: normal; 
     color: #333;
     text-align: center;
     "),
        
        # 🔹 Primeira linha: Caixas de filtros lado a lado
        fluidRow(
          # Caixa de filtros para o Gráfico 1
          box(
            width = 6, 
            title = "Opções de filtro para o Gráfico 1",
            solidHeader = TRUE, 
            status = "primary", 
            collapsible = TRUE, 
            collapsed = FALSE,
            fluidRow(
              column(width = 4,
                     selectInput(inputId = 'nivel_analise_pop1',
                                 label = "Selecione o nível de análise:",
                                 choices = c("Município" = "nome_mn",
                                             "Região Intermediária" = "nome_rg",
                                             "Porte Populacional" = "portepop"),
                                 selected = "nome_mn")
              ),
              column(width = 4,
                     uiOutput("filtroUnidade_pop1")
              ),
              column(width = 4,
                     selectInput("faixa_etaria_pop1", "Selecione o grupo etário:",
                                 choices = c("0-14", "15-59", "60+"),
                                 selected = c("0-14", "15-59", "60+"),
                                 multiple = TRUE)
              )
            )
          ),
          
          # Caixa de filtros para o Gráfico 2
          box(
            width = 6, 
            title = "Opções de filtro para o Gráfico 2",
            solidHeader = TRUE, 
            status = "primary", 
            collapsible = TRUE, 
            collapsed = FALSE,
            fluidRow(
              column(width = 4,
                     selectInput(inputId = 'nivel_analise_pop2',
                                 label = "Selecione o nível de análise:",
                                 choices = c("Município" = "nome_mn",
                                             "Região Intermediária" = "nome_rg",
                                             "Porte Populacional" = "portepop"),
                                 selected = "nome_mn")
              ),
              column(width = 4,
                     uiOutput("filtroUnidade_pop2")
              ),
              column(width = 4,
                     selectInput("faixa_etaria_pop2", "Selecione o grupo etário:",
                                 choices = c("0-14", "15-59", "60+"),
                                 selected = c("0-14", "15-59", "60+"),
                                 multiple = TRUE)
              )
            )
          )
        ),
        
        # 🔹 Segunda linha: Caixas dos gráficos diretamente abaixo dos filtros
        fluidRow(
          # Gráfico 1
          box(
            width = 6, 
            title = "Gráfico 1",
            solidHeader = TRUE,
            status = "info",
            collapsible = TRUE,
            highchartOutput(outputId = 'grafico_pop1', height = "500px")
          ),
          
          # Gráfico 2
          box(
            width = 6, 
            title = "Gráfico 2",
            solidHeader = TRUE,
            status = "info",
            collapsible = TRUE,
            highchartOutput(outputId = 'grafico_pop2', height = "500px")
          )
        )
      ),
      
      # 5- Razão de dependência
      tabItem(
        tabName = 'opcao2',
        
        h1("Razão de dependência da população de Minas Gerais", 
           style = "
     margin-top: 10px;
     font-family: 'Arial'; 
     font-size: 24px; 
     font-weight: bold; 
     color: #333;
     text-align: center;
     "),
        h2("Instruções: Selecione o nível de análise (Município, Região intermediária e 
           Porte populacional), a unidade desejada e o tipo de razão de dependência. 
           Repita o mesmo processo no Gráfico 2 para realizar comparações.", 
           style = "
     margin-top: 10px;
     font-family: 'Arial'; 
     font-size: 15px; 
     font-weight: normal; 
     color: #333;
     text-align: center;
     "),
        
        # 🔹 Primeira linha: Caixas de filtros lado a lado
        fluidRow(
          # Caixa de filtros para o Gráfico 1
          box(
            width = 6, 
            title = "Opções de filtro para Gráfico 1",
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            collapsed = FALSE,
            fluidRow(
              column(width = 4,
                     selectInput("escala11", "Selecione o nível de análise:",
                                 choices = c(
                                   "Município" = "mn",
                                   "Região Intermediária" = "rg",
                                   "Porte Populacional" = "porte"
                                 )
                     )
              ),
              column(width = 4,
                     uiOutput("filtroEscala11") # Filtro dinâmico
              ),
              column(width = 4,
                     selectInput("tipo_razao11", "Selecione a razão de dependência:",
                                 choices = c("Total", "Jovem", "Idosa"),
                                 selected = c("Total", "Jovem", "Idosa"),
                                 multiple = TRUE)
              )
            )
          ),
          
          # Caixa de filtros para o Gráfico 2
          box(
            width = 6, 
            title = "Opções de filtro para Gráfico 2",
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            collapsed = FALSE,
            fluidRow(
              column(width = 4,
                     selectInput("escala22", "Selecione o nível de análise:",
                                 choices = c(
                                   "Município" = "mn",
                                   "Região Intermediária" = "rg",
                                   "Porte Populacional" = "porte"
                                 )
                     )
              ),
              column(width = 4,
                     uiOutput("filtroEscala22") # Filtro dinâmico
              ),
              column(width = 4,
                     selectInput("tipo_razao22", "Selecione a razão de dependência:",
                                 choices = c("Total", "Jovem", "Idosa"),
                                 selected = c("Total", "Jovem", "Idosa"),
                                 multiple = TRUE)
              )
            )
          )
        ),
        
        # 🔹 Segunda linha: Caixas dos gráficos diretamente abaixo dos filtros
        fluidRow(
          # Gráfico 1
          box(
            width = 6,
            title = "Gráfico 1",
            solidHeader = TRUE,
            status = "info",
            collapsible = TRUE,
            highchartOutput("graficoRazao1", height = "500px")
          ),
          
          # Gráfico 2
          box(
            width = 6,
            title = "Gráfico 2",
            solidHeader = TRUE,
            status = "info",
            collapsible = TRUE,
            highchartOutput("graficoRazao2", height = "500px")
          )
        )
      ),
      
      # 6 - PERCENTUAIS
      
      tabItem(
        tabName = 'opcao03', 
        
        h1("Percentuais populacionais de Minas Gerais por grupos selecionados", 
           style = "
     margin-top: 10px;
     font-family: 'Arial'; 
     font-size: 24px; 
     font-weight: bold; 
     color: #333;
     text-align: center;
     "),
        h2("Instruções: Selecione o nível de análise (Município, 
     Região intermediária e Porte populacional), a unidade desejada e o grupo populacional.
           Repita o mesmo processo no Gráfico 2 para realizar comparações.", 
           style = "
     margin-top: 10px;
     font-family: 'Arial'; 
     font-size: 15px; 
     font-weight: normal; 
     color: #333;
     text-align: center;
     "),
        
        # 🔹 Primeira linha: Caixas de filtros lado a lado
        fluidRow(
          # Caixa de filtros para o Gráfico 1 (Percentuais Populacionais)
          box(
            width = 6, 
            title = "Opções de filtro para Gráfico 1",
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            collapsed = FALSE,
            fluidRow(
              column(width = 4,
                     selectInput("escala_percentual03_1", "Selecione o nível de análise:",
                                 choices = c(
                                   "Município" = "mn",
                                   "Região Intermediária" = "rg",
                                   "Porte Populacional" = "porte"
                                 )
                     )
              ),
              column(width = 4,
                     uiOutput("filtroEscalaPercentual03_1")  # Filtro dinâmico
              ),
              column(width = 4,
                     selectInput("tipo_percentual03_1", "Selecione o grupo:",
                                 choices = c("Percentual 5 anos ou menos",
                                             "Percentual 60 anos ou mais",
                                             "Percentual 65 anos ou mais"),
                                 selected = c("Percentual 5 anos ou menos",
                                              "Percentual 60 anos ou mais",
                                              "Percentual 65 anos ou mais"),
                                 multiple = TRUE)
              )
            )
          ),
          
          # Caixa de filtros para o Gráfico 2 (Percentuais Populacionais)
          box(
            width = 6, 
            title = "Opções de filtro para Gráfico 2",
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            collapsed = FALSE,
            fluidRow(
              column(width = 4,
                     selectInput("escala_percentual03_2", "Selecione o nível de análise:",
                                 choices = c(
                                   "Município" = "mn",
                                   "Região Intermediária" = "rg",
                                   "Porte Populacional" = "porte"
                                 )
                     )
              ),
              column(width = 4,
                     uiOutput("filtroEscalaPercentual03_2")  # Filtro dinâmico
              ),
              column(width = 4,
                     selectInput("tipo_percentual03_2", "Selecione o grupo:",
                                 choices = c("Percentual 5 anos ou menos",
                                             "Percentual 60 anos ou mais",
                                             "Percentual 65 anos ou mais"),
                                 selected = c("Percentual 5 anos ou menos",
                                              "Percentual 60 anos ou mais",
                                              "Percentual 65 anos ou mais"),
                                 multiple = TRUE)
              )
            )
          )
        ),
        
        # 🔹 Segunda linha: Caixas dos gráficos diretamente abaixo dos filtros
        fluidRow(
          # Gráfico 1 (Percentuais Populacionais)
          box(
            width = 6,
            title = "Gráfico 1",
            solidHeader = TRUE,
            status = "info",
            collapsible = TRUE,
            highchartOutput("grafico_percentual03_1", height = "500px")
          ),
          
          # Gráfico 2 (Percentuais Populacionais)
          box(
            width = 6,
            title = "Gráfico 2",
            solidHeader = TRUE,
            status = "info",
            collapsible = TRUE,
            highchartOutput("grafico_percentual03_2", height = "500px")
          )
        )
      ),
      
      # 6 - IE
      tabItem(
        tabName = 'opcao3', 
        
        h1("Índice de envelhecimento e percentual da população de Minas Gerais por grupos selecionados", 
           style = "
     margin-top: 10px;
     font-family: 'Arial'; 
     font-size: 24px; 
     font-weight: bold; 
     color: #333;
     text-align: center;
     "),
        h2("Instruções: Selecione o nível de análise (Município, 
     Região intermediária e Porte populacional), a unidade desejada e o agrupamento de 
     pessoas idosas. Repita o mesmo processo no Gráfico 2 para realizar comparações.", 
           style = "
     margin-top: 10px;
     font-family: 'Arial'; 
     font-size: 15px; 
     font-weight: normal; 
     color: #333;
     text-align: center;
     "),
        
        # 🔹 Primeira linha: Caixas de filtros lado a lado
        fluidRow(
          # Caixa de filtros para o Gráfico 1 (Índice de Envelhecimento)
          box(
            width = 6, 
            title = "Opções de filtro para Gráfico 1",
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            collapsed = FALSE,
            fluidRow(
              column(width = 4,
                     selectInput("escala_indicador3_1", "Selecione o nível de análise:",
                                 choices = c(
                                   "Município" = "mn",
                                   "Região Intermediária" = "rg",
                                   "Porte Populacional" = "porte"
                                 )
                     )
              ),
              column(width = 4,
                     uiOutput("filtroEscalaIndicador3_1") # Filtro dinâmico
              ),
              column(width = 4,
                     selectInput("indicador_idade3_1", "Selecione o índice de envelhecimento:",
                                 choices = c(
                                   "60+/0 a 14",
                                   "65+/0 a 14",
                                   "80+/0 a 14"
                                 ),
                                 selected = c(
                                   "60+/0 a 14",
                                   "65+/0 a 14",
                                   "80+/0 a 14"
                                 ),
                                 multiple = TRUE)  # Permite seleção múltipla
              )
            )
          ),
          
          # Caixa de filtros para o Gráfico 2 (Índice de Envelhecimento)
          box(
            width = 6, 
            title = "Opções de filtro para Gráfico 2",
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            collapsed = FALSE,
            fluidRow(
              column(width = 4,
                     selectInput("escala_indicador3_2", "Selecione o nível de análise:",
                                 choices = c(
                                   "Município" = "mn",
                                   "Região Intermediária" = "rg",
                                   "Porte Populacional" = "porte"
                                 )
                     )
              ),
              column(width = 4,
                     uiOutput("filtroEscalaIndicador3_2") # Filtro dinâmico
              ),
              column(width = 4,
                     selectInput("indicador_idade3_2", "Selecione o índice de envelhecimento:",
                                 choices = c(
                                   "60+/0 a 14",
                                   "65+/0 a 14",
                                   "80+/0 a 14"
                                 ),
                                 selected = c(
                                   "60+/0 a 14",
                                   "65+/0 a 14",
                                   "80+/0 a 14"
                                 ),
                                 multiple = TRUE)  # Permite seleção múltipla
              )
            )
          )
        ),
        
        # 🔹 Segunda linha: Caixas dos gráficos diretamente abaixo dos filtros
        fluidRow(
          # Gráfico 1 (Índice de Envelhecimento)
          box(
            width = 6,
            title = "Gráfico 1",
            solidHeader = TRUE,
            status = "info",
            collapsible = TRUE,
            highchartOutput("grafico_indicador3_1", height = "500px")
          ),
          
          # Gráfico 2 (Índice de Envelhecimento)
          box(
            width = 6,
            title = "Gráfico 2",
            solidHeader = TRUE,
            status = "info",
            collapsible = TRUE,
            highchartOutput("grafico_indicador3_2", height = "500px")
          )
        )
      ),
      tabItem(tabName = 'opcao4',
              fluidRow(
                width = 12,
                h2("GOVERNADOR DO ESTADO DE MINAS GERAIS", style = "margin-left: 10px; font-weight: bold; font-size: 22px;"),
                h3("Romeu Zema Neto", style = "margin-left: 30px; font-size: 18px;"),
                h2("SECRETÁRIA DE ESTADO DE PLANEJAMENTO E GESTÃO", style = "margin-top:30px; margin-left: 10px; font-weight: bold; font-size: 22px;"),
                h3("Silvia Caroline Listgarten Dias", style = "margin-left: 30px; font-size: 18px;"),
                h2("FUNDAÇÃO JOÃO PINHEIRO (FJP)", style = "margin-top:30px; margin-left: 10px; font-weight: bold; font-size: 22px;"),
                h3("Presidente", style = "margin-left: 30px; font-weight: bold; font-size: 18px;"),
                h4("Luciana Lopes Nominato Braga", style = "margin-left: 44px; font-size: 18px;"),
                h3("Vice-Presidente", style = "margin-left: 30px; font-weight: bold; font-size: 18px;"),
                h4("Mônica Moreira Esteves Bernardi", style = "margin-left: 44px; font-size: 18px;"),
                h2("DIRETORIA DE ESTATÍSTICA E INFORMAÇÕES (Direi)", style = "margin-top:30px; margin-left: 10px; font-weight: bold; font-size: 22px;"),
                h3("Cláudio Djissey Shikida", style = "margin-left: 30px; font-size: 18px;"),
                h2("Coordenação de Indicadores Sociais (CIS)", style = "margin-top:30px; margin-left: 10px; font-weight: bold; font-size: 22px;"),
                h3("Caio César Soares Gonçalves", style = "margin-left: 30px; font-size: 18px;"),
                h2("Equipe Técnica", style = "margin-top:30px; margin-left: 10px; font-weight: bold; font-size: 22px;"),
                h3("Denise Helena França Marques Maia (coord.)", style = "margin-left: 30px; font-size: 18px;"),
                h3("Cláudia Júlia Guimarães", style = "margin-left: 30px; font-size: 18px;"),
                h3("Helena Teixeira Magalhães Soares", style = "margin-left: 30px; font-size: 18px;"),
                h3("Marcos José Freddi Bassoli", style = "margin-left: 30px; font-size: 18px;"),
                h3("Marcos Damasceno", style = "margin-left: 30px; font-size: 18px;"),
                h3("Damien Franca Huchet", style = "margin-left: 30px; font-size: 18px;"),
                h2("Desenvolvimento", style = "margin-top:30px; margin-left: 10px; font-weight: bold; font-size: 22px;"),
                h3("Damien Franca Huchet", style = "margin-left: 30px; font-size: 18px;")
              )
      )
    ),
  ))

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  
  # # 🔹 1 - VISÃO GERAL DO CRESCIMENTO - Renderizar o filtro de unidades baseado no nível de análise
  # # 🔹 Filtro dinâmico para a escala selecionada (Gráfico 1)
  # output$filtroUnidade1 <- renderUI({
  #   req(input$nivel_analise1)
  #   
  #   if (input$nivel_analise1 == "MG") {
  #     choices <- "Minas Gerais"
  #     selectInput("municipios1", "Selecione a unidade:", choices = choices, selected = "Minas Gerais")
  #   } else if (input$nivel_analise1 == "nome_mn") {
  #     choices <- unique(base_pop_idade_mn_vg$nome_mn)
  #     selectInput("municipios1", "Selecione o município:", choices = choices)
  #   } else if (input$nivel_analise1 == "nome_rg") {
  #     choices <- unique(base_pop_idade_rg_vg$nome_rg)
  #     selectInput("municipios1", "Selecione a região intermediária:", choices = choices)
  #   } else {
  #     # Ordena as categorias de "Porte Populacional"
  #     choices <- factor(
  #       unique(base_pop_idade_porte_vg$portepop),
  #       levels = c(
  #         "Até 5 mil habitantes",
  #         "5.001 a 10 mil habitantes",
  #         "10.001 a 30 mil habitantes",
  #         "30.001 a 100 mil habitantes",
  #         "100.001 a 500 mil habitantes",
  #         "Mais de 500 mil habitantes"
  #       )
  #     )
  #     choices <- sort(choices)  # Aplica a ordenação
  #     selectInput("municipios1", "Selecione o porte populacional:", choices = choices)
  #   }
  # })
  # 
  # # 🔹 Filtro dinâmico para a escala selecionada (Gráfico 2)
  # output$filtroUnidade2 <- renderUI({
  #   req(input$nivel_analise2)
  #   
  #   if (input$nivel_analise2 == "MG") {
  #     choices <- "Minas Gerais"
  #     selectInput("municipios2", "Selecione a unidade:", choices = choices, selected = "Minas Gerais")
  #   } else if (input$nivel_analise2 == "nome_mn") {
  #     choices <- unique(base_pop_idade_mn_vg$nome_mn)
  #     selectInput("municipios2", "Selecione o município:", choices = choices)
  #   } else if (input$nivel_analise2 == "nome_rg") {
  #     choices <- unique(base_pop_idade_rg_vg$nome_rg)
  #     selectInput("municipios2", "Selecione a região intermediária:", choices = choices)
  #   } else {
  #     # Ordena as categorias de "Porte Populacional"
  #     choices <- factor(
  #       unique(base_pop_idade_porte_vg$portepop),
  #       levels = c(
  #         "Até 5 mil habitantes",
  #         "5.001 a 10 mil habitantes",
  #         "10.001 a 30 mil habitantes",
  #         "30.001 a 100 mil habitantes",
  #         "100.001 a 500 mil habitantes",
  #         "Mais de 500 mil habitantes"
  #       )
  #     )
  #     choices <- sort(choices)  # Aplica a ordenação
  #     selectInput("municipios2", "Selecione o porte populacional:", choices = choices)
  #   }
  # })
  # 
  # # 🔹 Função para gerar os gráficos
  # gerarGraficoPopulacao <- function(nivel_analise, municipios, sexo) {
  #   req(municipios, sexo, nivel_analise)
  #   
  #   dados_final <- list()
  #   
  #   for (unidade in municipios) {
  #     
  #     if (nivel_analise == "MG") {
  #       dados_base <- pop_minas_gerais
  #       dados_sexo <- pop_minas_gerais_sexo
  #       filtro_col <- "categoria"  # Coluna fictícia para Minas Gerais
  #     } else if (nivel_analise == "nome_mn") {
  #       dados_base <- base_pop_idade_mn_vg
  #       dados_sexo <- base_pop_idade_mn_sexo_vg
  #       filtro_col <- "nome_mn"
  #     } else if (nivel_analise == "nome_rg") {
  #       dados_base <- base_pop_idade_rg_vg
  #       dados_sexo <- base_pop_idade_rg_sexo_vg
  #       filtro_col <- "nome_rg"
  #     } else {
  #       dados_base <- base_pop_idade_porte_vg
  #       dados_sexo <- base_pop_idade_porte_sexo_vg
  #       filtro_col <- "portepop"
  #     }
  #     
  #     if ("Total" %in% sexo) {
  #       dados_total <- dados_base %>%
  #         filter(if (nivel_analise == "MG") TRUE else !!sym(filtro_col) == unidade) %>%
  #         select(ano, pop_total)
  #       
  #       dados_final <- append(dados_final, list(
  #         list(name = paste(unidade, "(Total)"), data = list_parse2(dados_total))
  #       ))
  #     }
  #     
  #     if ("Homens" %in% sexo) {
  #       dados_homens <- dados_sexo %>%
  #         filter(if (nivel_analise == "MG") TRUE else !!sym(filtro_col) == unidade, sexo == "H") %>%
  #         select(ano, pop_total)
  #       
  #       dados_final <- append(dados_final, list(
  #         list(name = paste(unidade, "(Homens)"), data = list_parse2(dados_homens))
  #       ))
  #     }
  #     
  #     if ("Mulheres" %in% sexo) {
  #       dados_mulheres <- dados_sexo %>%
  #         filter(if (nivel_analise == "MG") TRUE else !!sym(filtro_col) == unidade, sexo == "M") %>%
  #         select(ano, pop_total)
  #       
  #       dados_final <- append(dados_final, list(
  #         list(name = paste(unidade, "(Mulheres)"), data = list_parse2(dados_mulheres))
  #       ))
  #     }
  #   }
  #   
  #   h <- highchart() %>%
  #     hc_chart(type = "line",
  #              events = list(
  #                load = JS("function() {
  #               var chart = this;
  #               chart.renderer.text('Fonte: Fundação João Pinheiro', 
  #                   10, chart.chartHeight - 3) // 
  #                   .css({
  #                       color: '#555',
  #                       fontSize: '12px'
  #                   }).add();
  #            }")
  #              )) %>%
  #     hc_xAxis(title = list(text = "Ano"), categories = c(2022, 2025, 2026, 2027, 2032, 2037, 2042, 2047)) %>%
  #     hc_yAxis(
  #       title = list(text = "População Total"),
  #       labels = list(
  #         formatter = JS("function() {
  #         if (this.value >= 1000000) {
  #           return (this.value / 1000000) + 'M';
  #         } else if (this.value >= 1000) {
  #           return (this.value / 1000) + 'mil';
  #         } else {
  #           return this.value;
  #         }
  #       }")
  #       )
  #     ) %>%
  #     hc_tooltip(shared = TRUE) %>%
  #     hc_exporting(enabled = TRUE, fallbackToExportServer = FALSE) %>% 
  #     hc_title(text = municipios) 
  #   
  #   
  #   for (serie in dados_final) {
  #     h <- h %>% hc_add_series(name = serie$name, data = serie$data)
  #   }
  #   
  #   return(h)
  # }
  # 
  # output$grafico1 <- renderHighchart({
  #   gerarGraficoPopulacao(input$nivel_analise1, input$municipios1, input$sexo1)
  # })
  # 
  # output$grafico2 <- renderHighchart({
  #   gerarGraficoPopulacao(input$nivel_analise2, input$municipios2, input$sexo2)
  # })
  # 
  # # 2 - TAXA DE CRESCIMENTO
  # 
  # # 🔹 Filtro dinâmico para a escala selecionada (Gráfico 1 - Taxa de Crescimento)
  # output$filtroEscalaTaxa011_1 <- renderUI({
  #   req(input$escala_taxa011_1)
  #   
  #   if (input$escala_taxa011_1 == "nome_mn") {
  #     choices <- unique(base_tx_mn_total$nome_mn)
  #   } else if (input$escala_taxa011_1 == "nome_rg") {
  #     choices <- unique(base_tx_rg_total$nome_rg)
  #   } else {
  #     # Ordena as categorias de "Porte Populacional"
  #     choices <- factor(
  #       unique(base_tx_porte_total$portepop),
  #       levels = c(
  #         "Até 5 mil habitantes",
  #         "5.001 a 10 mil habitantes",
  #         "10.001 a 30 mil habitantes",
  #         "30.001 a 100 mil habitantes",
  #         "100.001 a 500 mil habitantes",
  #         "Mais de 500 mil habitantes"
  #       )
  #     )
  #     choices <- sort(choices)  # Aplica a ordenação
  #   }
  #   
  #   selectInput("unidade_taxa011_1", "Selecione a unidade:", choices = choices)
  # })
  # 
  # # 🔹 Filtro dinâmico para a escala selecionada (Gráfico 2 - Taxa de Crescimento)
  # output$filtroEscalaTaxa011_2 <- renderUI({
  #   req(input$escala_taxa011_2)
  #   
  #   if (input$escala_taxa011_2 == "nome_mn") {
  #     choices <- unique(base_tx_mn_total$nome_mn)
  #   } else if (input$escala_taxa011_2 == "nome_rg") {
  #     choices <- unique(base_tx_rg_total$nome_rg)
  #   } else {
  #     # Ordena as categorias de "Porte Populacional"
  #     choices <- factor(
  #       unique(base_tx_porte_total$portepop),
  #       levels = c(
  #         "Até 5 mil habitantes",
  #         "5.001 a 10 mil habitantes",
  #         "10.001 a 30 mil habitantes",
  #         "30.001 a 100 mil habitantes",
  #         "100.001 a 500 mil habitantes",
  #         "Mais de 500 mil habitantes"
  #       )
  #     )
  #     choices <- sort(choices)  # Aplica a ordenação
  #   }
  #   
  #   selectInput("unidade_taxa011_2", "Selecione a unidade:", choices = choices)
  # })
  # 
  # # 🔹 Gráfico 1 - Taxa de Crescimento
  # output$grafico_taxa011_1 <- renderHighchart({
  #   req(input$escala_taxa011_1, input$unidade_taxa011_1)
  #   
  #   dados <- switch(input$escala_taxa011_1,
  #                   "nome_mn" = base_tx_mn_total,
  #                   "nome_rg" = base_tx_rg_total,
  #                   "portepop" = base_tx_porte_total)
  #   
  #   dados_filtrados <- dados %>%
  #     filter(if (input$escala_taxa011_1 == "nome_mn") nome_mn == input$unidade_taxa011_1
  #            else if (input$escala_taxa011_1 == "nome_rg") nome_rg == input$unidade_taxa011_1
  #            else portepop == input$unidade_taxa011_1)
  #   
  #   highchart() %>%
  #     hc_chart(type = "column",
  #              events = list(
  #                load = JS("function() {
  #               var chart = this;
  #               chart.renderer.text('Fonte: Fundação João Pinheiro', 
  #                   10, chart.chartHeight - 3) // 
  #                   .css({
  #                       color: '#555',
  #                       fontSize: '12px'
  #                   }).add();
  #            }")
  #              )) %>%
  #     hc_xAxis(categories = unique(dados_filtrados$tx_cresc)) %>%
  #     hc_yAxis(title = list(text = "Taxa de Crescimento")) %>%
  #     hc_add_series(name = "Taxa de Crescimento", data = dados_filtrados$valor) %>%
  #     hc_tooltip(pointFormat = "{point.y:.4f}") %>%
  #     hc_exporting(enabled = TRUE) %>% 
  #     hc_title(text = input$unidade_taxa011_1)
  # })
  # 
  # # 🔹 Gráfico 2 - Taxa de Crescimento
  # output$grafico_taxa011_2 <- renderHighchart({
  #   req(input$escala_taxa011_2, input$unidade_taxa011_2)
  #   
  #   dados <- switch(input$escala_taxa011_2,
  #                   "nome_mn" = base_tx_mn_total,
  #                   "nome_rg" = base_tx_rg_total,
  #                   "portepop" = base_tx_porte_total)
  #   
  #   dados_filtrados <- dados %>%
  #     filter(if (input$escala_taxa011_2 == "nome_mn") nome_mn == input$unidade_taxa011_2
  #            else if (input$escala_taxa011_2 == "nome_rg") nome_rg == input$unidade_taxa011_2
  #            else portepop == input$unidade_taxa011_2)
  #   
  #   highchart() %>%
  #     hc_chart(type = "column",
  #              events = list(
  #                load = JS("function() {
  #               var chart = this;
  #               chart.renderer.text('Fonte: Fundação João Pinheiro', 
  #                   10, chart.chartHeight - 3) // 
  #                   .css({
  #                       color: '#555',
  #                       fontSize: '12px'
  #                   }).add();
  #            }")
  #              )) %>%
  #     hc_xAxis(categories = unique(dados_filtrados$tx_cresc)) %>%
  #     hc_yAxis(title = list(text = "Taxa de Crescimento")) %>%
  #     hc_add_series(name = "Taxa de Crescimento", data = dados_filtrados$valor) %>%
  #     hc_tooltip(pointFormat = "{point.y:.4f}") %>%
  #     hc_exporting(enabled = TRUE) %>% 
  #     hc_title(text = input$unidade_taxa011_2)
  # })
  # 
  # 
  # # 🔹 2 - PIRÂMIDES - Filtro dinâmico para a escala selecionada (Pirâmide 1)
  # output$filtroEscala1 <- renderUI({
  #   req(input$escala1)
  #   
  #   if (input$escala1 == "MG") {
  #     selectInput("filtro1", "Selecione a unidade:", choices = "Minas Gerais", selected = "Minas Gerais")
  #   } else {
  #     escolhas <- unique(pop_interp_mm_idade_shiny_proj[[input$escala1]])
  #     
  #     # Ordena as categorias de "Porte Populacional" se a escala for "portepop"
  #     if (input$escala1 == "portepop") {
  #       escolhas <- factor(
  #         escolhas,
  #         levels = c(
  #           "Até 5 mil habitantes",
  #           "5.001 a 10 mil habitantes",
  #           "10.001 a 30 mil habitantes",
  #           "30.001 a 100 mil habitantes",
  #           "100.001 a 500 mil habitantes",
  #           "Mais de 500 mil habitantes"
  #         )
  #       )
  #       escolhas <- sort(escolhas)  # Aplica a ordenação
  #     }
  #     
  #     selectInput("filtro1", "Selecione a unidade:", choices = escolhas)
  #   }
  # })
  # 
  # # 🔹 Filtro dinâmico para a escala selecionada (Pirâmide 2)
  # output$filtroEscala2 <- renderUI({
  #   req(input$escala2)
  #   
  #   if (input$escala2 == "MG") {
  #     selectInput("filtro2", "Selecione a unidade:", choices = "Minas Gerais", selected = "Minas Gerais")
  #   } else {
  #     escolhas <- unique(pop_interp_mm_idade_shiny_proj[[input$escala2]])
  #     
  #     # Ordena as categorias de "Porte Populacional" se a escala for "portepop"
  #     if (input$escala2 == "portepop") {
  #       escolhas <- factor(
  #         escolhas,
  #         levels = c(
  #           "Até 5 mil habitantes",
  #           "5.001 a 10 mil habitantes",
  #           "10.001 a 30 mil habitantes",
  #           "30.001 a 100 mil habitantes",
  #           "100.001 a 500 mil habitantes",
  #           "Mais de 500 mil habitantes"
  #         )
  #       )
  #       escolhas <- sort(escolhas)  # Aplica a ordenação
  #     }
  #     
  #     selectInput("filtro2", "Selecione a unidade:", choices = escolhas)
  #   }
  # })
  # 
  # # 🔹 Gerar a pirâmide etária 1 com Highcharter
  # output$piramideEtaria1 <- renderHighchart({
  #   req(input$escala1, input$filtro1, input$ano1)
  #   
  #   if (input$escala1 == "MG") {
  #     dados_filtrados <- pop_interp_mm_idade_shiny_proj %>%
  #       filter(ano == input$ano1)
  #   } else {
  #     dados_filtrados <- pop_interp_mm_idade_shiny_proj %>%
  #       filter(!!sym(input$escala1) == input$filtro1, ano == input$ano1)
  #   }
  #   
  #   gerarGraficoPiramide(dados_filtrados, input$filtro1, input$ano1)
  # })
  # 
  # # 🔹 Gerar a pirâmide etária 2 com Highcharter
  # output$piramideEtaria2 <- renderHighchart({
  #   req(input$escala2, input$filtro2, input$ano2)
  #   
  #   if (input$escala2 == "MG") {
  #     dados_filtrados <- pop_interp_mm_idade_shiny_proj %>%
  #       filter(ano == input$ano2)
  #   } else {
  #     dados_filtrados <- pop_interp_mm_idade_shiny_proj %>%
  #       filter(!!sym(input$escala2) == input$filtro2, ano == input$ano2)
  #   }
  #   
  #   gerarGraficoPiramide(dados_filtrados, input$filtro2, input$ano2)
  # })
  # 
  # # 🔹 Função auxiliar para gerar gráfico de pirâmide etária
  # gerarGraficoPiramide <- function(dados, filtro, ano) {
  #   breaks <- seq(0, 80, by = 5)
  #   labels <- as.character(breaks)
  #   labels[length(labels)] <- paste0(breaks[length(labels)], "+")
  #   
  #   dados_plot <- dados %>%
  #     mutate(
  #       pop_menor = ifelse(sexo == "H", -pop_menor, pop_menor), # Valores negativos para homens
  #       faixa_etaria = cut(idade, breaks = c(breaks, Inf), right = FALSE, labels = labels)
  #     ) %>%
  #     group_by(faixa_etaria, sexo) %>%
  #     summarise(populacao = sum(pop_menor), .groups = 'drop') %>%
  #     pivot_wider(names_from = sexo, values_from = populacao, values_fill = 0) %>%
  #     arrange(desc(faixa_etaria))
  #   
  #   highchart() %>%
  #     hc_chart(type = "bar",
  #              events = list(
  #                load = JS("function() {
  #             var chart = this;
  #             chart.renderer.text('Fonte: Fundação João Pinheiro', 
  #                 10, chart.chartHeight - 3) // 
  #                 .css({
  #                     color: '#555',
  #                     fontSize: '12px'
  #                 }).add();
  #          }")
  #              )) %>%
  #     hc_xAxis(categories = dados_plot$faixa_etaria,
  #              title = list(text = "Faixa Etária"),
  #              reversed = TRUE) %>%
  #     hc_yAxis(
  #       title = list(text = "População total"),
  #       labels = list(
  #         formatter = JS("function() {
  #         var value = Math.abs(this.value);
  #         if (value >= 1000000) {
  #           return (value / 1000000) + 'M';
  #         } else if (value >= 1000) {
  #           return (value / 1000) + 'mil';
  #         } else {
  #           return value;
  #         }
  #       }")
  #       ),
  #       reversed = FALSE
  #     ) %>%
  #     hc_plotOptions(series = list(stacking = "normal")) %>%
  #     hc_add_series(name = "Homens", data = dados_plot$H, color = "#4e79a7") %>%
  #     hc_add_series(name = "Mulheres", data = dados_plot$M, color = "#f28e2b") %>%
  #     hc_title(text = paste(filtro, " - ", ano)) %>%
  #     hc_tooltip(
  #       shared = TRUE,
  #       formatter = JS("function() {
  #       var homens = Math.abs(this.points[0].y); // Valor absoluto para homens
  #       var mulheres = this.points[1].y;        // Mulheres já está positivo
  #       return '<b>' + this.x + '</b><br/>' +
  #              'Homens: ' + homens.toLocaleString() + '<br/>' +
  #              'Mulheres: ' + mulheres.toLocaleString();
  #     }"))%>%
  #     hc_exporting(enabled = TRUE, fallbackToExportServer = FALSE)
  # }
  # 
  # # 3 - RS 
  # # 🔹 Filtro dinâmico para a escala selecionada (Gráfico 1 - Razão de Sexo)
  # output$filtroEscalaIndicador110_1 <- renderUI({
  #   req(input$escala_indicador110_1)
  #   
  #   if (input$escala_indicador110_1 == "nome_mn") {
  #     choices <- unique(rs_mn$nome_mn)
  #   } else if (input$escala_indicador110_1 == "nome_rg") {
  #     choices <- unique(rs_rg$nome_rg)
  #   } else {
  #     # Define a ordem desejada para as categorias de "Porte Populacional"
  #     portepop_levels <- c(
  #       "Até 5.000 habitantes",         # Corrigido para corresponder à base de dados
  #       "5.001 a 10 mil habitantes",
  #       "10.001 a 30 mil habitantes",
  #       "30.001 a 100 mil habitantes",
  #       "100.001 a 500 mil habitantes",
  #       "Mais de 500 mil habitantes"
  #     )
  #     
  #     # Filtra apenas as categorias presentes nos dados
  #     choices <- unique(rs_porte$id)
  #     choices <- factor(choices, levels = portepop_levels)
  #     choices <- as.character(na.omit(choices))  # Remove níveis ausentes
  #   }
  #   
  #   selectInput("unidade_indicador110_1", "Selecione a unidade:", choices = choices)
  # })
  # 
  # # 🔹 Filtro dinâmico para a escala selecionada (Gráfico 2 - Razão de Sexo)
  # output$filtroEscalaIndicador110_2 <- renderUI({
  #   req(input$escala_indicador110_2)
  #   
  #   if (input$escala_indicador110_2 == "nome_mn") {
  #     choices <- unique(rs_mn$nome_mn)
  #   } else if (input$escala_indicador110_2 == "nome_rg") {
  #     choices <- unique(rs_rg$nome_rg)
  #   } else {
  #     # Define a ordem desejada para as categorias de "Porte Populacional"
  #     portepop_levels <- c(
  #       "Até 5.000 habitantes",         # Corrigido para corresponder à base de dados
  #       "5.001 a 10 mil habitantes",
  #       "10.001 a 30 mil habitantes",
  #       "30.001 a 100 mil habitantes",
  #       "100.001 a 500 mil habitantes",
  #       "Mais de 500 mil habitantes"
  #     )
  #     
  #     # Filtra apenas as categorias presentes nos dados
  #     choices <- unique(rs_porte$id)
  #     choices <- factor(choices, levels = portepop_levels)
  #     choices <- as.character(na.omit(choices))  # Remove níveis ausentes
  #   }
  #   
  #   selectInput("unidade_indicador110_2", "Selecione a unidade:", choices = choices)
  # })
  # 
  # # 🔹 Gráfico 1 - Razão de Sexo
  # output$grafico_indicador110_1 <- renderHighchart({
  #   req(input$escala_indicador110_1, input$unidade_indicador110_1, input$ano_indicador110_1)
  #   
  #   dados <- switch(input$escala_indicador110_1,
  #                   "nome_mn" = rs_mn,
  #                   "nome_rg" = rs_rg,
  #                   "id" = rs_porte)
  #   
  #   dados_filtrados <- dados %>%
  #     filter(if (input$escala_indicador110_1 == "nome_mn") nome_mn == input$unidade_indicador110_1
  #            else if (input$escala_indicador110_1 == "nome_rg") nome_rg == input$unidade_indicador110_1
  #            else id == input$unidade_indicador110_1,
  #            ano == input$ano_indicador110_1)
  #   
  #   highchart() %>%
  #     hc_chart(type = "line",
  #              events = list(
  #                load = JS("function() {
  #               var chart = this;
  #               chart.renderer.text('Fonte: Fundação João Pinheiro', 
  #                   10, chart.chartHeight - 3) // 
  #                   .css({
  #                       color: '#555',
  #                       fontSize: '12px'
  #                   }).add();
  #            }")
  #              )) %>%
  #     hc_xAxis(categories = unique(dados_filtrados$fe), title = list(text = "Grupo etário")) %>%
  #     hc_yAxis(title = list(text = "Razão de sexo")) %>%
  #     hc_add_series(name = "Razão de sexo", data = dados_filtrados$indicador) %>%
  #     hc_tooltip(pointFormat = "{point.y:.2f}") %>%
  #     hc_exporting(enabled = TRUE) %>% 
  #     hc_title(text = input$unidade_indicador110_1)
  # })
  # 
  # # 🔹 Gráfico 2 - Razão de Sexo
  # output$grafico_indicador110_2 <- renderHighchart({
  #   req(input$escala_indicador110_2, input$unidade_indicador110_2, input$ano_indicador110_2)
  #   
  #   dados <- switch(input$escala_indicador110_2,
  #                   "nome_mn" = rs_mn,
  #                   "nome_rg" = rs_rg,
  #                   "id" = rs_porte)
  #   
  #   dados_filtrados <- dados %>%
  #     filter(if (input$escala_indicador110_2 == "nome_mn") nome_mn == input$unidade_indicador110_2
  #            else if (input$escala_indicador110_2 == "nome_rg") nome_rg == input$unidade_indicador110_2
  #            else id == input$unidade_indicador110_2,
  #            ano == input$ano_indicador110_2)
  #   
  #   highchart() %>%
  #     hc_chart(type = "line",
  #              events = list(
  #                load = JS("function() {
  #               var chart = this;
  #               chart.renderer.text('Fonte: Fundação João Pinheiro', 
  #                   10, chart.chartHeight - 3) // 
  #                   .css({
  #                       color: '#555',
  #                       fontSize: '12px'
  #                   }).add();
  #            }")
  #              )) %>%
  #     hc_xAxis(categories = unique(dados_filtrados$fe), title = list(text = "Grupo etário")) %>%
  #     hc_yAxis(title = list(text = "Razão de sexo")) %>%
  #     hc_add_series(name = "Razão de sexo", data = dados_filtrados$indicador) %>%
  #     hc_tooltip(pointFormat = "{point.y:.2f}") %>%
  #     hc_exporting(enabled = TRUE) %>% 
  #     hc_title(text = input$unidade_indicador110_2)
  # })
  # 
  # # 🔹 4 - CRESC POR IDADE - Filtro dinâmico para a unidade (Gráfico 1)
  # 
  # # 🔹 Atualiza dinamicamente as opções do segundo filtro com base no nível de análise
  # output$filtroUnidade_pop1 <- renderUI({
  #   req(input$nivel_analise_pop1)
  #   choices <- switch(input$nivel_analise_pop1,
  #                     "nome_mn" = unique(base_pop_idade_mn_total$nome_mn),
  #                     "nome_rg" = unique(base_pop_idade_rg_total$nome_rg),
  #                     "portepop" = {
  #                       # Define a ordem desejada para as categorias de "Porte Populacional"
  #                       portepop_ordered <- factor(
  #                         unique(base_pop_idade_porte_total$portepop),
  #                         levels = c(
  #                           "Até 5 mil habitantes",
  #                           "5.001 a 10 mil habitantes",
  #                           "10.001 a 30 mil habitantes",
  #                           "30.001 a 100 mil habitantes",
  #                           "100.001 a 500 mil habitantes",
  #                           "Mais de 500 mil habitantes"
  #                         )
  #                       )
  #                       # Ordena as categorias
  #                       sort(portepop_ordered)
  #                     })
  #   selectInput("unidade_pop1", "Selecione a unidade:", choices = choices)
  # })
  # 
  # output$filtroUnidade_pop2 <- renderUI({
  #   req(input$nivel_analise_pop2)
  #   choices <- switch(input$nivel_analise_pop2,
  #                     "nome_mn" = unique(base_pop_idade_mn_total$nome_mn),
  #                     "nome_rg" = unique(base_pop_idade_rg_total$nome_rg),
  #                     "portepop" = {
  #                       # Define a ordem desejada para as categorias de "Porte Populacional"
  #                       portepop_ordered <- factor(
  #                         unique(base_pop_idade_porte_total$portepop),
  #                         levels = c(
  #                           "Até 5 mil habitantes",
  #                           "5.001 a 10 mil habitantes",
  #                           "10.001 a 30 mil habitantes",
  #                           "30.001 a 100 mil habitantes",
  #                           "100.001 a 500 mil habitantes",
  #                           "Mais de 500 mil habitantes"
  #                         )
  #                       )
  #                       # Ordena as categorias
  #                       sort(portepop_ordered)
  #                     })
  #   selectInput("unidade_pop2", "Selecione a unidade:", choices = choices)
  # })
  # 
  # # 🔹 Atualização dos gráficos com os novos anos e filtros de faixa etária
  # criar_grafico <- function(nivel_analise, unidade, faixa_etaria, output_id) {
  #   req(nivel_analise, unidade, faixa_etaria)
  #   
  #   dados_base <- switch(nivel_analise,
  #                        "nome_mn" = base_pop_idade_mn_total,
  #                        "nome_rg" = base_pop_idade_rg_total,
  #                        "portepop" = base_pop_idade_porte_total)
  #   
  #   filtro_col <- nivel_analise
  #   
  #   dados_final <- dados_base %>%
  #     filter(!!sym(filtro_col) %in% unidade, faixa_etaria %in% faixa_etaria, ano %in% c(2022, 2025, 2026, 2027, 2032, 2037, 2042, 2047)) %>%
  #     group_by(ano, faixa_etaria) %>%
  #     summarise(pop_total = sum(pop_total, na.rm = TRUE), .groups = "drop")
  #   
  #   if (nrow(dados_final) == 0) {
  #     output[[output_id]] <- renderHighchart({ NULL })
  #     return(NULL)
  #   }
  #   
  #   h <- highchart() %>%
  #     hc_size(width = 850, height = 500) %>%
  #     hc_xAxis(title = list(text = "Ano"), categories = c(2022, 2025, 2026, 2027, 2032, 2037, 2042, 2047)) %>%
  #     hc_chart(type = "line",
  #              events = list(
  #                load = JS("function() {
  #               var chart = this;
  #               chart.renderer.text('Fonte: Fundação João Pinheiro', 
  #                   10, chart.chartHeight - 3) // 
  #                   .css({
  #                       color: '#555',
  #                       fontSize: '12px'
  #                   }).add();
  #            }")
  #              )) %>%
  #     hc_yAxis(
  #       title = list(text = "População Total"),
  #       labels = list(
  #         formatter = JS("function() {
  #         if (this.value >= 1000000) {
  #           return (this.value / 1000000) + 'M';
  #         } else if (this.value >= 1000) {
  #           return (this.value / 1000) + 'mil';
  #         } else {
  #           return this.value;
  #         }
  #       }")
  #       )
  #     ) %>%
  #     hc_title(text = paste0(unidade)) %>%
  #     hc_tooltip(pointFormat = "{point.y:,.0f}") %>%
  #     hc_legend(enabled = TRUE) %>%
  #     hc_exporting(enabled = TRUE, buttons = list(contextButton = list(menuItems = c('downloadPNG', 'downloadJPEG', 'downloadSVG'))))
  #   
  #   for (faixa in faixa_etaria) {
  #     dados_faixa <- dados_final %>% filter(faixa_etaria == faixa)
  #     h <- h %>%
  #       hc_add_series(data = list_parse2(dados_faixa %>% select(ano, pop_total)),
  #                     name = faixa,
  #                     type = "line")
  #   }
  #   
  #   output[[output_id]] <- renderHighchart({ h })
  # }
  # 
  # observeEvent({input$unidade_pop1; input$faixa_etaria_pop1}, {
  #   criar_grafico(input$nivel_analise_pop1, input$unidade_pop1, input$faixa_etaria_pop1, "grafico_pop1")
  # })
  # 
  # observeEvent({input$unidade_pop2; input$faixa_etaria_pop2}, {
  #   criar_grafico(input$nivel_analise_pop2, input$unidade_pop2, input$faixa_etaria_pop2, "grafico_pop2")
  # })
  # 
  # 
  # # 🔹 5 - RAZÃO DE DEPENDÊNCIA 
  # # Função para obter a base de dados correta
  # get_razao_base <- function(tipos_razao, escala) {
  #   bases <- list(
  #     Total = list(
  #       mn = razao_dep_total_mn,
  #       rg = razao_dep_total_rg,
  #       porte = razao_dep_total_porte
  #     ),
  #     Jovem = list(
  #       mn = razao_dep_jovem_mn,
  #       rg = razao_dep_jovem_rg,
  #       porte = razao_dep_jovem_porte
  #     ),
  #     Idosa = list(
  #       mn = razao_dep_idosa_mn,
  #       rg = razao_dep_idosa_rg,
  #       porte = razao_dep_idosa_porte
  #     )
  #   )
  #   
  #   bases_selecionadas <- lapply(tipos_razao, function(tipo) bases[[tipo]][[escala]])
  #   base_final <- do.call(rbind, bases_selecionadas)
  #   
  #   return(base_final)
  # }
  # 
  # # 🔹 Função para padronizar e ordenar as categorias de "Porte Populacional"
  # ordenar_porte_populacional <- function(categorias) {
  #   # Função para converter uma categoria em um valor numérico
  #   converter_para_numero <- function(categoria) {
  #     if (grepl("Até", categoria)) {
  #       # Extrai o número da categoria "Até X habitantes"
  #       numero <- as.numeric(gsub("[^0-9.]", "", categoria))
  #     } else if (grepl("Mais de", categoria)) {
  #       # Extrai o número da categoria "Mais de X habitantes"
  #       numero <- as.numeric(gsub("[^0-9.]", "", categoria))
  #     } else {
  #       # Extrai o número inicial da categoria "X a Y habitantes"
  #       numero <- as.numeric(gsub("[^0-9.]", "", strsplit(categoria, " ")[[1]][1]))
  #     }
  #     
  #     # Converte "mil" para 1000
  #     if (grepl("mil", categoria)) {
  #       numero <- numero * 1000
  #     }
  #     
  #     return(numero)
  #   }
  #   
  #   # Cria um data.frame com as categorias e seus valores numéricos
  #   df_categorias <- data.frame(
  #     categoria = categorias,
  #     valor = sapply(categorias, converter_para_numero)
  #   )
  #   
  #   # Ordena as categorias com base nos valores numéricos
  #   df_categorias <- df_categorias[order(df_categorias$valor), ]
  #   
  #   return(df_categorias$categoria)
  # }
  # 
  # # 🔹 Filtro dinâmico para Razão de Dependência (Gráfico 1)
  # output$filtroEscala11 <- renderUI({
  #   req(input$escala11, input$tipo_razao11)
  #   
  #   base <- get_razao_base(input$tipo_razao11, input$escala11)
  #   
  #   coluna_filtro <- switch(input$escala11,
  #                           "mn" = "nome_mn",
  #                           "rg" = "nome_rg",
  #                           "porte" = "id")
  #   
  #   choices <- unique(base[[coluna_filtro]])
  #   
  #   # Ordena as categorias de "Porte Populacional" se a escala for "porte"
  #   if (input$escala11 == "porte") {
  #     choices <- ordenar_porte_populacional(choices)
  #   }
  #   
  #   selectInput("filtroRDP1", "Selecione a unidade:", choices = choices)
  # })
  # 
  # # 🔹 Filtro dinâmico para Razão de Dependência (Gráfico 2)
  # output$filtroEscala22 <- renderUI({
  #   req(input$escala22, input$tipo_razao22)
  #   
  #   base <- get_razao_base(input$tipo_razao22, input$escala22)
  #   
  #   coluna_filtro <- switch(input$escala22,
  #                           "mn" = "nome_mn",
  #                           "rg" = "nome_rg",
  #                           "porte" = "id")
  #   
  #   choices <- unique(base[[coluna_filtro]])
  #   
  #   # Ordena as categorias de "Porte Populacional" se a escala for "porte"
  #   if (input$escala22 == "porte") {
  #     choices <- ordenar_porte_populacional(choices)
  #   }
  #   
  #   selectInput("filtroRDP2", "Selecione a unidade:", choices = choices)
  # })
  # 
  # # 🔹 Gerar gráfico para Razão de Dependência 1
  # output$graficoRazao1 <- renderHighchart({
  #   req(input$escala11, input$filtroRDP1, input$tipo_razao11)
  #   
  #   anos_referencia <- unique(razao_dep_total_mn$ano)
  #   
  #   h <- highchart() %>%
  #     hc_chart(type = "line",
  #              events = list(
  #                load = JS("function() {
  #               var chart = this;
  #               chart.renderer.text('Fonte: Fundação João Pinheiro', 
  #                   10, chart.chartHeight - 3) // 
  #                   .css({
  #                       color: '#555',
  #                       fontSize: '12px'
  #                   }).add();
  #            }")
  #              )) %>%
  #     hc_xAxis(categories = anos_referencia, title = list(text = "Ano")) %>%
  #     hc_yAxis(title = list(text = "Razão de Dependência")) %>%
  #     hc_tooltip(shared = TRUE) %>%
  #     hc_exporting(enabled = TRUE) %>% 
  #     hc_title(text = paste(input$filtroRDP1))
  #   
  #   for (tipo in input$tipo_razao11) {
  #     base <- get_razao_base(tipo, input$escala11)
  #     
  #     coluna_filtro <- switch(input$escala11,
  #                             "mn" = "nome_mn",
  #                             "rg" = "nome_rg",
  #                             "porte" = "id")
  #     
  #     dados_filtrados <- base %>%
  #       filter(!!sym(coluna_filtro) == input$filtroRDP1) %>%
  #       arrange(ano)
  #     
  #     cor <- if (tipo == "Total") "#0080FF" else if (tipo == "Jovem") "#FF8000" else "#8000FF"
  #     
  #     h <- h %>%
  #       hc_add_series(name = paste("Razão de Dependência -", tipo),
  #                     data = dados_filtrados$indicador,
  #                     color = cor)
  #   }
  #   
  #   h
  # })
  # 
  # # 🔹 Gerar gráfico para Razão de Dependência 2
  # output$graficoRazao2 <- renderHighchart({
  #   req(input$escala22, input$filtroRDP2, input$tipo_razao22)
  #   
  #   anos_referencia <- unique(razao_dep_total_mn$ano)
  #   
  #   h <- highchart() %>%
  #     hc_chart(type = "line",
  #              events = list(
  #                load = JS("function() {
  #               var chart = this;
  #               chart.renderer.text('Fonte: Fundação João Pinheiro', 
  #                   10, chart.chartHeight - 3) // 
  #                   .css({
  #                       color: '#555',
  #                       fontSize: '12px'
  #                   }).add();
  #            }")
  #              )) %>%
  #     hc_xAxis(categories = anos_referencia, title = list(text = "Ano")) %>%
  #     hc_yAxis(title = list(text = "Razão de Dependência")) %>%
  #     hc_tooltip(shared = TRUE) %>%
  #     hc_exporting(enabled = TRUE) %>% 
  #     hc_title(text = paste(input$filtroRDP2))
  #   
  #   for (tipo in input$tipo_razao22) {
  #     base <- get_razao_base(tipo, input$escala22)
  #     
  #     coluna_filtro <- switch(input$escala22,
  #                             "mn" = "nome_mn",
  #                             "rg" = "nome_rg",
  #                             "porte" = "id")
  #     
  #     dados_filtrados <- base %>%
  #       filter(!!sym(coluna_filtro) == input$filtroRDP2) %>%
  #       arrange(ano)
  #     
  #     cor <- if (tipo == "Total") "#0080FF" else if (tipo == "Jovem") "#FF8000" else "#8000FF"
  #     
  #     h <- h %>%
  #       hc_add_series(name = paste("Razão de Dependência -", tipo),
  #                     data = dados_filtrados$indicador,
  #                     color = cor)
  #   }
  #   
  #   h
  # })
  # 
  # # 6 - PERCENTUAIS
  # 
  # # 🔹 Filtro dinâmico para os Percentuais Populacionais (Gráfico 1)
  # output$filtroEscalaPercentual03_1 <- renderUI({
  #   req(input$escala_percentual03_1)
  #   
  #   base <- switch(input$escala_percentual03_1,
  #                  "mn" = percentual_menor_de_5_anos_mn,
  #                  "rg" = percentual_menor_de_5_anos_rg,
  #                  "porte" = percentual_menor_de_5_anos_porte)
  #   
  #   coluna_filtro <- switch(input$escala_percentual03_1,
  #                           "mn" = "nome_mn",
  #                           "rg" = "nome_rg",
  #                           "porte" = "id")
  #   
  #   choices <- unique(base[[coluna_filtro]])
  #   
  #   # Ordena as categorias de "Porte Populacional" se a escala for "porte"
  #   if (input$escala_percentual03_1 == "porte") {
  #     choices <- factor(choices, levels = c(
  #       "Até 5 mil habitantes",
  #       "5.001 a 10 mil habitantes",
  #       "10.001 a 30 mil habitantes",
  #       "30.001 a 100 mil habitantes",
  #       "100.001 a 500 mil habitantes",
  #       "Mais de 500 mil habitantes"
  #     ))
  #     choices <- as.character(sort(choices))  # Aplica a ordenação
  #   }
  #   
  #   selectInput("unidade_percentual03_1", "Selecione a unidade:", choices = choices)
  # })
  # 
  # # 🔹 Filtro dinâmico para os Percentuais Populacionais (Gráfico 2)
  # output$filtroEscalaPercentual03_2 <- renderUI({
  #   req(input$escala_percentual03_2)
  #   
  #   base <- switch(input$escala_percentual03_2,
  #                  "mn" = percentual_menor_de_5_anos_mn,
  #                  "rg" = percentual_menor_de_5_anos_rg,
  #                  "porte" = percentual_menor_de_5_anos_porte)
  #   
  #   coluna_filtro <- switch(input$escala_percentual03_2,
  #                           "mn" = "nome_mn",
  #                           "rg" = "nome_rg",
  #                           "porte" = "id")
  #   
  #   choices <- unique(base[[coluna_filtro]])
  #   
  #   # Ordena as categorias de "Porte Populacional" se a escala for "porte"
  #   if (input$escala_percentual03_2 == "porte") {
  #     choices <- factor(choices, levels = c(
  #       "Até 5 mil habitantes",
  #       "5.001 a 10 mil habitantes",
  #       "10.001 a 30 mil habitantes",
  #       "30.001 a 100 mil habitantes",
  #       "100.001 a 500 mil habitantes",
  #       "Mais de 500 mil habitantes"
  #     ))
  #     choices <- as.character(sort(choices))  # Aplica a ordenação
  #   }
  #   
  #   selectInput("unidade_percentual03_2", "Selecione a unidade:", choices = choices)
  # })
  # 
  # # 🔹 Gráfico 1 - Percentuais Populacionais
  # output$grafico_percentual03_1 <- renderHighchart({
  #   req(input$escala_percentual03_1, input$unidade_percentual03_1, input$tipo_percentual03_1)
  #   
  #   bases <- list(
  #     "Percentual 5 anos ou menos" = list(
  #       "mn" = percentual_menor_de_5_anos_mn,
  #       "rg" = percentual_menor_de_5_anos_rg,
  #       "porte" = percentual_menor_de_5_anos_porte
  #     ),
  #     "Percentual 65 anos ou mais" = list(
  #       "mn" = percentual_maior_de_65_anos_mn,
  #       "rg" = percentual_maior_de_65_anos_rg,
  #       "porte" = percentual_maior_de_65_anos_porte
  #     ),
  #     "Percentual 60 anos ou mais" = list(
  #       "mn" = percentual_maior_de_60_anos_mn,
  #       "rg" = percentual_maior_de_60_anos_rg,
  #       "porte" = percentual_maior_de_60_anos_porte
  #     )
  #   )
  #   
  #   h <- highchart() %>%
  #     hc_chart(type = "line",
  #              events = list(
  #                load = JS("function() {
  #               var chart = this;
  #               chart.renderer.text('Fonte: Fundação João Pinheiro', 
  #                   10, chart.chartHeight - 3) // 
  #                   .css({
  #                       color: '#555',
  #                       fontSize: '12px'
  #                   }).add();
  #            }")
  #              )) %>%
  #     hc_xAxis(title = list(text = "Ano"), categories = anos) %>%
  #     hc_yAxis(title = list(text = "Percentual da População")) %>%
  #     hc_tooltip(pointFormat = "{point.y:,.0f}") %>%
  #     hc_exporting(enabled = TRUE) %>% 
  #     hc_title(text = input$unidade_percentual03_1)
  #   
  #   for (tipo in input$tipo_percentual03_1) {
  #     base <- bases[[tipo]][[input$escala_percentual03_1]]
  #     
  #     coluna_filtro <- switch(input$escala_percentual03_1,
  #                             "mn" = "nome_mn",
  #                             "rg" = "nome_rg",
  #                             "porte" = "id")
  #     
  #     dados_filtrados <- base %>%
  #       filter(!!sym(coluna_filtro) == input$unidade_percentual03_1, ano %in% anos) %>%
  #       arrange(ano)
  #     
  #     h <- h %>%
  #       hc_add_series(name = paste(input$unidade_percentual03_1, "-", tipo), 
  #                     data = dados_filtrados$indicador)
  #   }
  #   
  #   h
  # })
  # 
  # # 🔹 Gráfico 2 - Percentuais Populacionais
  # output$grafico_percentual03_2 <- renderHighchart({
  #   req(input$escala_percentual03_2, input$unidade_percentual03_2, input$tipo_percentual03_2)
  #   
  #   bases <- list(
  #     "Percentual 5 anos ou menos" = list(
  #       "mn" = percentual_menor_de_5_anos_mn,
  #       "rg" = percentual_menor_de_5_anos_rg,
  #       "porte" = percentual_menor_de_5_anos_porte
  #     ),
  #     "Percentual 65 anos ou mais" = list(
  #       "mn" = percentual_maior_de_65_anos_mn,
  #       "rg" = percentual_maior_de_65_anos_rg,
  #       "porte" = percentual_maior_de_65_anos_porte
  #     ),
  #     "Percentual 60 anos ou mais" = list(
  #       "mn" = percentual_maior_de_60_anos_mn,
  #       "rg" = percentual_maior_de_60_anos_rg,
  #       "porte" = percentual_maior_de_60_anos_porte
  #     )
  #   )
  #   
  #   h <- highchart() %>%
  #     hc_chart(type = "line",
  #              events = list(
  #                load = JS("function() {
  #               var chart = this;
  #               chart.renderer.text('Fonte: Fundação João Pinheiro', 
  #                   10, chart.chartHeight - 3) // 
  #                   .css({
  #                       color: '#555',
  #                       fontSize: '12px'
  #                   }).add();
  #            }")
  #              )) %>%
  #     hc_xAxis(title = list(text = "Ano"), categories = anos) %>%
  #     hc_yAxis(title = list(text = "Percentual da População")) %>%
  #     hc_tooltip(pointFormat = "{point.y:,.0f}") %>%
  #     hc_exporting(enabled = TRUE) %>% 
  #     hc_title(text = input$unidade_percentual03_2)
  #   
  #   for (tipo in input$tipo_percentual03_2) {
  #     base <- bases[[tipo]][[input$escala_percentual03_2]]
  #     
  #     coluna_filtro <- switch(input$escala_percentual03_2,
  #                             "mn" = "nome_mn",
  #                             "rg" = "nome_rg",
  #                             "porte" = "id")
  #     
  #     dados_filtrados <- base %>%
  #       filter(!!sym(coluna_filtro) == input$unidade_percentual03_2, ano %in% anos) %>%
  #       arrange(ano)
  #     
  #     h <- h %>%
  #       hc_add_series(name = paste(input$unidade_percentual03_2, "-", tipo), 
  #                     data = dados_filtrados$indicador)
  #   }
  #   
  #   h
  # })
  # 
  # # 6🔹- IE
  # # 🔹 Filtro dinâmico para o Índice de Envelhecimento (Gráfico 1)
  # output$filtroEscalaIndicador3_1 <- renderUI({
  #   req(input$escala_indicador3_1)
  #   
  #   base <- switch(input$escala_indicador3_1,
  #                  "mn" = indice_de_envelhecimento_mn_60,
  #                  "rg" = indice_de_envelhecimento_rg_60,
  #                  "porte" = indice_de_envelhecimento_porte_60)
  #   
  #   coluna_filtro <- switch(input$escala_indicador3_1,
  #                           "mn" = "nome_mn",
  #                           "rg" = "nome_rg",
  #                           "porte" = "portepop")  # Atualizado para "portepop"
  #   
  #   choices <- unique(base[[coluna_filtro]])
  #   
  #   # Ordena as categorias de "Porte Populacional" se a escala for "porte"
  #   if (input$escala_indicador3_1 == "porte") {
  #     choices <- factor(choices, levels = c(
  #       "Até 5 mil habitantes",
  #       "5.001 a 10 mil habitantes",
  #       "10.001 a 30 mil habitantes",
  #       "30.001 a 100 mil habitantes",
  #       "100.001 a 500 mil habitantes",
  #       "Mais de 500 mil habitantes"
  #     ))
  #     choices <- as.character(sort(choices))  # Aplica a ordenação
  #   }
  #   
  #   selectInput("unidade_indicador3_1", "Selecione a unidade:", choices = choices)
  # })
  # 
  # # 🔹 Filtro dinâmico para o Índice de Envelhecimento (Gráfico 2)
  # output$filtroEscalaIndicador3_2 <- renderUI({
  #   req(input$escala_indicador3_2)
  #   
  #   base <- switch(input$escala_indicador3_2,
  #                  "mn" = indice_de_envelhecimento_mn_60,
  #                  "rg" = indice_de_envelhecimento_rg_60,
  #                  "porte" = indice_de_envelhecimento_porte_60)
  #   
  #   coluna_filtro <- switch(input$escala_indicador3_2,
  #                           "mn" = "nome_mn",
  #                           "rg" = "nome_rg",
  #                           "porte" = "portepop")  # Atualizado para "portepop"
  #   
  #   choices <- unique(base[[coluna_filtro]])
  #   
  #   # Ordena as categorias de "Porte Populacional" se a escala for "porte"
  #   if (input$escala_indicador3_2 == "porte") {
  #     choices <- factor(choices, levels = c(
  #       "Até 5 mil habitantes",
  #       "5.001 a 10 mil habitantes",
  #       "10.001 a 30 mil habitantes",
  #       "30.001 a 100 mil habitantes",
  #       "100.001 a 500 mil habitantes",
  #       "Mais de 500 mil habitantes"
  #     ))
  #     choices <- as.character(sort(choices))  # Aplica a ordenação
  #   }
  #   
  #   selectInput("unidade_indicador3_2", "Selecione a unidade:", choices = choices)
  # })
  # 
  # # 🔹 Definição correta do eixo X com todas as categorias de anos
  # anos <- unique(indice_de_envelhecimento_mn_60$ano)  # Todos os anos disponíveis
  # anos_plotar <- c(2022, 2025, 2026, 2027, 2032, 2037, 2042, 2047)  # Anos específicos para plotar
  # 
  # # 🔹 Gráfico 1 - Índice de Envelhecimento
  # output$grafico_indicador3_1 <- renderHighchart({
  #   req(input$escala_indicador3_1, input$unidade_indicador3_1, input$indicador_idade3_1)
  #   
  #   bases_indicadores <- list(
  #     "60+/0 a 14" = list(
  #       "mn" = indice_de_envelhecimento_mn_60,
  #       "rg" = indice_de_envelhecimento_rg_60,
  #       "porte" = indice_de_envelhecimento_porte_60
  #     ),
  #     "65+/0 a 14" = list(
  #       "mn" = indice_de_envelhecimento_mn_65,
  #       "rg" = indice_de_envelhecimento_rg_65,
  #       "porte" = indice_de_envelhecimento_porte_65
  #     ),
  #     "80+/0 a 14" = list(
  #       "mn" = indice_de_envelhecimento_mn_80,
  #       "rg" = indice_de_envelhecimento_rg_80,
  #       "porte" = indice_de_envelhecimento_porte_80
  #     )
  #   )
  #   
  #   h <- highchart() %>%
  #     hc_chart(type = "line",
  #              events = list(
  #                load = JS("function() {
  #               var chart = this;
  #               chart.renderer.text('Fonte: Fundação João Pinheiro', 
  #                   10, chart.chartHeight - 3) // 
  #                   .css({
  #                       color: '#555',
  #                       fontSize: '12px'
  #                   }).add();
  #            }")
  #              )) %>%
  #     hc_xAxis(title = list(text = "Ano"), categories = as.character(anos)) %>%
  #     hc_yAxis(title = list(text = "Índice de Envelhecimento")) %>%
  #     hc_tooltip(shared = TRUE) %>%
  #     hc_exporting(enabled = TRUE) %>% 
  #     hc_title(text = input$unidade_indicador3_1)
  #   
  #   for (indicador in input$indicador_idade3_1) {
  #     base <- bases_indicadores[[indicador]][[input$escala_indicador3_1]]
  #     
  #     coluna_filtro <- switch(input$escala_indicador3_1,
  #                             "mn" = "nome_mn",
  #                             "rg" = "nome_rg",
  #                             "porte" = "portepop")  # Atualizado para "portepop"
  #     
  #     dados_filtrados <- base %>%
  #       filter(!!sym(coluna_filtro) == input$unidade_indicador3_1, ano %in% anos) %>%
  #       arrange(ano)
  #     
  #     h <- h %>%
  #       hc_add_series(name = paste(input$unidade_indicador3_1, "-", indicador), 
  #                     data = dados_filtrados$indicador)
  #   }
  #   
  #   h
  # })
  # 
  # 
  # 
  # # 🔹 Gráfico 2 - Índice de Envelhecimento
  # output$grafico_indicador3_2 <- renderHighchart({
  #   req(input$escala_indicador3_2, input$unidade_indicador3_2, input$indicador_idade3_2)
  #   
  #   bases_indicadores <- list(
  #     "60+/0 a 14" = list(
  #       "mn" = indice_de_envelhecimento_mn_60,
  #       "rg" = indice_de_envelhecimento_rg_60,
  #       "porte" = indice_de_envelhecimento_porte_60
  #     ),
  #     "65+/0 a 14" = list(
  #       "mn" = indice_de_envelhecimento_mn_65,
  #       "rg" = indice_de_envelhecimento_rg_65,
  #       "porte" = indice_de_envelhecimento_porte_65
  #     ),
  #     "80+/0 a 14" = list(
  #       "mn" = indice_de_envelhecimento_mn_80,
  #       "rg" = indice_de_envelhecimento_rg_80,
  #       "porte" = indice_de_envelhecimento_porte_80
  #     )
  #   )
  #   
  #   h <- highchart() %>%
  #     hc_chart(type = "line",
  #              events = list(
  #                load = JS("function() {
  #               var chart = this;
  #               chart.renderer.text('Fonte: Fundação João Pinheiro', 
  #                   10, chart.chartHeight - 3) // 
  #                   .css({
  #                       color: '#555',
  #                       fontSize: '12px'
  #                   }).add();
  #            }")
  #              )) %>%
  #     hc_xAxis(title = list(text = "Ano"), categories = as.character(anos)) %>%
  #     hc_yAxis(title = list(text = "Índice de Envelhecimento")) %>%
  #     hc_tooltip(shared = TRUE) %>%
  #     hc_exporting(enabled = TRUE) %>% 
  #     hc_title(text = input$unidade_indicador3_2)
  #   
  #   for (indicador in input$indicador_idade3_2) {
  #     base <- bases_indicadores[[indicador]][[input$escala_indicador3_2]]
  #     
  #     coluna_filtro <- switch(input$escala_indicador3_2,
  #                             "mn" = "nome_mn",
  #                             "rg" = "nome_rg",
  #                             "porte" = "portepop")  # Atualizado para "portepop"
  #     
  #     dados_filtrados <- base %>%
  #       filter(!!sym(coluna_filtro) == input$unidade_indicador3_2, ano %in% anos) %>%
  #       arrange(ano)
  #     
  #     h <- h %>%
  #       hc_add_series(name = paste(input$unidade_indicador3_2, "-", indicador), 
  #                     data = dados_filtrados$indicador)
  #   }
  #   
  #   h
  # })
  
}

# Run the application
shinyApp(ui = ui, server = server)

