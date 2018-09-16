library(ggplot2)
library(forcats)
library(DT)
library(dplyr)
#library(plyr)
library(ggformula)


# Define UI for dataset viewer app ----
ui <- fluidPage(navbarPage(title = 'find your wine!',
       tabPanel('Info',
                fluidPage(
                  h1("Find Your Wine"),
                  p("This App helps you to find your wine. You can either search for 
                    a specific wine, based on variety, country, price and rating,
                    find the typical wine for your country or search countries where 
                    you can find specific a specific variety.")
                )),
       tabPanel('Find the most inexpensive wine',
         fluidPage(
           fluidRow(
             column(4,
                    # Input: Selector for choosing dataset ----
                    uiOutput('all_varieties')
             ),
             
             column(4,
                    # Input: Numeric entry for number of obs to view ----
                    numericInput(
                      inputId = "minRating",
                      label = "Minimum points to view:",
                      value = 0
                    )   
             ),
             column(4,
                    numericInput(
                      inputId = "minPrice",
                      label = "Minimum price to view:",
                      value = 0
                    )   
             )
          ),
          fluidRow(
            column(4,
                   # Input: Selector for choosing dataset ----
                   uiOutput('all_countries')
            ), 
            column(4,
                    numericInput(
                      inputId = "maxRating",
                      label = "Maximum points to view:",
                      value = 100
                    )   
             ),
             column(4,
                    numericInput(
                      inputId = "maxPrice",
                      label = "Maximum price to view:",
                      value = 2300
                    )   
             )
           ),
           # Main panel for displaying outputs ----
           mainPanel(
             tabsetPanel(
               tabPanel('table for all wines',
                        fluidPage(
                          p("In dieser Tabelle sieht der Nutzer die Weine entsprechend der Filterauswahl. 
                            Dabei sieht der Nutzer verschiedene Merkmale und deren Ausprägung."),
                          p("country ist ein nominales Merkmal, welches das Herkunftsland des Weines beschreibt."),
                          p("points ist eine Bewertung des Weines mit einer Zahl. Prinzipiell sieht der Ersteller
                            der App dieses Merkmal als ordinal an. Mehr Punkte bedeutet besserer Wein. Somit 
                            ist eine Ordnung herleitbar aber die Bedeutung von einem Punkt mehr ist nicht klar.
                            Für die Berechnung der price_points_ratio und die Korrelationskoeffizienten wird 
                            das Merkmal als metrisch betrachtet."),
                          p("price ist ein numerisches Merkmal. Eine Währung ist aber nicht bekannt. Das Merkmal
                            beschreibt die Kosten des Weines. Allerdings ist hier nicht klar für was diese 
                            Kosten entstehen. Das könnte für eine Flasche sein (Füllmenge der Flasche? 1,0l; 0,7l
                            ) oder aber auch ein Glas im Restaurant o.Ä. sein. Für diese App wird davon 
                            ausgegangen, dass die Einheiten für alle Weine gleich sind."),
                          p("price_points_ratio beschreibt die Kosten für einen Punkt. Dies dient der
                            Vergleichbarkeit gleich teurer und gleich gut bewerteter Weine. Ein Nutzer dieser App 
                            kann dies als Kaufgrundlage nutzen. (Bei gleich gut bewerteten Weinen der gleichen 
                            Sorte, kann er den Wein wählen, bei dem er weniger pro Punkt bezahlen muss,)"),
                          p("winery beschreibt den Hersteller des Weines. Dies ist ein ordinales Merkmal."),
                          p("variety beschreibt die Weinsorte. Dies ist ein ordinales Merkmal."),
                          # Create a new row for the table.
                          DT::dataTableOutput("table_all_data")
                        )
               ),
               tabPanel('number of wines per country',
                        fluidPage(plotOutput(outputId = "distPlot"))
               ),
               tabPanel('correlation between price and points',
                        textOutput("spearman"),
                        textOutput("pearson"),
                        fluidPage(plotOutput(outputId = "corrPlot_all"))
               ),
               tabPanel('summary of the data',
                        fluidPage(verbatimTextOutput("summary"))
               )
             )
           )
         )
       ),
       tabPanel('Find the wine for your country',
                fluidRow(
                  column(4,
                         # Input: Selector for choosing dataset ----
                         uiOutput('all_countries2')
                  ),
                  column(4,
                         numericInput(
                           inputId = "minPointsCountry",
                           label = "Minimum points to view:",
                           value = 0
                         )
                  ),
                  column(4,
                         numericInput(
                           inputId = "maxPointsCountry",
                           label = "Maximum points to view:",
                           value = 100
                         )  
                  ),
                  column(4,
                         numericInput(
                           inputId = "minPriceCountry",
                           label = "Minimum price to view:",
                           value = 0
                         )  
                  ),
                  column(4,
                         numericInput(
                           inputId = "maxPriceCountry",
                           label = "Maximum price to view:",
                           value = 2300
                         )
                  )
                ),
                # Main panel for displaying outputs ----
                mainPanel(
                  tabsetPanel(
                    tabPanel('Summary on varieties for your country',
                             fluidPage(
                               DT::dataTableOutput("table_varieties_for_country")
                             )
                    ),
                    tabPanel('correlation between price and points',
                             textOutput("spearman2"),
                             textOutput("pearson2"),
                             fluidPage(plotOutput(outputId = "corrPlot_country"))
                    ),
                    tabPanel('distribution of the variety for wineries',
                             fluidPage(plotOutput("plot_country"))
                    )
                  )
                )
          ),
       tabPanel('Find the countries for your variety',
                fluidRow(
                  column(4,
                         # Input: Selector for choosing dataset ----
                         uiOutput('all_varieties2')
                  ),
                  column(4,
                         numericInput(
                           inputId = "minPointsVariety",
                           label = "Minimum points to view:",
                           value = 0
                         )   
                  ),
                  column(4,
                         numericInput(
                           inputId = "maxPointsVariety",
                           label = "Maximum points to view:",
                           value = 100
                         )  
                  ),
                  column(4,
                         numericInput(
                           inputId = "minPriceVariety",
                           label = "Minimum price to view:",
                           value = 0
                         )
                  ),
                  column(4,
                         numericInput(
                           inputId = "maxPriceVariety",
                           label = "Maximum price to view:",
                           value = 2300
                         )   
                  )
                ),
                # Main panel for displaying outputs ----
                mainPanel(
                  tabsetPanel(
                    tabPanel('Summary on varieties for your country',
                             fluidPage(
                               DT::dataTableOutput("table_countries_for_variety")
                             )
                    ),
                    tabPanel('correlation between price and points',
                             textOutput("spearman3"),
                             textOutput("pearson3"),
                             fluidPage(plotOutput(outputId = "corrPlot_variety"))
                    )
                  )
                )
       )
       ))
