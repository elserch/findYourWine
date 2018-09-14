library(ggplot2)
library(forcats)
library(DT)
library(dplyr)
library(plyr)

# Define UI for dataset viewer app ----
ui <- fluidPage(navbarPage(title = 'find your wine!',
       tabPanel('Find the most inexpensive wine',
         # Sidebar layout with a input and output definitions ----
         sidebarLayout(
           # Sidebar panel for inputs ----
           sidebarPanel(

             # Input: Selector for choosing dataset ----
             uiOutput('all_varieties'),
             
             # Input: Selector for choosing dataset ----
             uiOutput('all_countries'),
             
             # Input: Numeric entry for number of obs to view ----
             numericInput(
               inputId = "minRating",
               label = "Minimum points to view:",
               value = 0
             ),
             numericInput(
               inputId = "maxPrice",
               label = "Maximum price to view:",
               value = 2300
             )
           ),
           
           # Main panel for displaying outputs ----
           mainPanel(
            # Create a new row for the table.
            DT::dataTableOutput("table_all_data"),
            # Output: Histogram
            plotOutput(outputId = "distPlot"),
            # Output: Verbatim text for data summary ----
            verbatimTextOutput("summary")
           )
         )
       ),
       tabPanel('Find the wine for your country',
            # Sidebar layout with a input and output definitions ----
            sidebarLayout(
              # Sidebar panel for inputs ----
              sidebarPanel(
                # Input: Selector for choosing dataset ----
                uiOutput('all_countries2'),
                numericInput(
                  inputId = "minPointsCountry",
                  label = "Minimum points to view:",
                  value = 0
                ),
                numericInput(
                  inputId = "maxPointsCountry",
                  label = "Maximum points to view:",
                  value = 100
                ),
                numericInput(
                  inputId = "minPriceCountry",
                  label = "Minimum price to view:",
                  value = 0
                ),
                numericInput(
                  inputId = "maxPriceCountry",
                  label = "Maximum price to view:",
                  value = 2300
                )
              ),
              # Main panel for displaying outputs ----
              mainPanel(
                # Create a new row for the table.
                DT::dataTableOutput("table_varieties_for_country"),
                plotOutput("plot_country")
                
              )
            )
          ),
       tabPanel('Find the countries for your variety',
                # Sidebar layout with a input and output definitions ----
                sidebarLayout(
                  # Sidebar panel for inputs ----
                  sidebarPanel(
                    # Input: Selector for choosing dataset ----
                    uiOutput('all_varieties2'),
                    numericInput(
                      inputId = "minPointsVariety",
                      label = "Minimum points to view:",
                      value = 0
                    ),
                    numericInput(
                      inputId = "maxPointsVariety",
                      label = "Maximum points to view:",
                      value = 100
                    ),
                    numericInput(
                      inputId = "minPriceVariety",
                      label = "Minimum price to view:",
                      value = 0
                    ),
                    numericInput(
                      inputId = "maxPriceVariety",
                      label = "Maximum price to view:",
                      value = 2300
                    )
                  ),
                  # Main panel for displaying outputs ----
                  mainPanel(
                    # Create a new row for the table.
                    DT::dataTableOutput("table_countries_for_variety"),
                    plotOutput("plot_variety")
                    
                  )
                )
       )
       ))
