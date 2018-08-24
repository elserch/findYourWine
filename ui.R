library(ggplot2)
library(forcats)
library(DT)
<<<<<<< HEAD
#library(plotly)
=======
source('helper.R')


>>>>>>> 0752584b24921702512723152907a95344d8d3ee


# Define UI for dataset viewer app ----
ui <- fluidPage(navbarPage(title = 'find your wine!',
       tabPanel('Find the most inexpensive wine',
         # Sidebar layout with a input and output definitions ----
         sidebarLayout(
           # Sidebar panel for inputs ----
           sidebarPanel(

             # Input: Selector for choosing dataset ----
<<<<<<< HEAD
             uiOutput('all_varieties'),
             
             # Input: Selector for choosing dataset ----
             uiOutput('all_countries'),
             
=======
             selectInput(
               inputId = "country",
               label = "Choose the country of your wine:",
               choices = c(find_all_unique_countries())
             ),
             # Input: Selector for choosing dataset ----
             selectInput(
               inputId = "variety",
               label = "Choose the variety of your wine:",
               choices = c(find_all_unique_varieties())
             ),
>>>>>>> 0752584b24921702512723152907a95344d8d3ee
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
<<<<<<< HEAD
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
                uiOutput('all_countries2')
              ),
              # Main panel for displaying outputs ----
              mainPanel(
                # Create a new row for the table.
                DT::dataTableOutput("table_varieties_for_country"),
                
                plotOutput("plot")
                
              )
            )
          ),
       tabPanel('Find the countries for your variety',
=======
             # Create a new row for the table.
             DT::dataTableOutput("table_all_data"),
             # Output: Histogram
             plotOutput(outputId = "distPlot_count_country"),
             plotOutput(outputId = "distPlot_count_variety"),
             # Output: Verbatim text for data summary ----
             verbatimTextOutput("summary")
             
             
           )
         )
       ),
       tabPanel('Search for variety',
                # Sidebar layout with a input and output definitions ----
                sidebarLayout(
                  # Sidebar panel for inputs ----
                  sidebarPanel(
                    # Input: Selector for choosing dataset ----
                    selectInput(
                      inputId = "country_by_variety",
                      label = "Choose the country of your wine:",
                      choices = c(find_all_unique_countries())
                    ),
                    htmlOutput("variableUI"),
                    # Input: Selector for choosing dataset ----
                    # Input: Numeric entry for number of obs to view ----
                    numericInput(
                      inputId = "minRating_by_variety",
                      label = "Minimum points to view:",
                      value = 0
                    ),
                    numericInput(
                      inputId = "maxPrice_by_variety",
                      label = "Maximum price to view:",
                      value = 2300
                    )
                  ),
                  # Main panel for displaying outputs ----
                  mainPanel(
                    tableOutput("table")
                  )
                  )),
       tabPanel('Search for Country',
>>>>>>> 0752584b24921702512723152907a95344d8d3ee
                # Sidebar layout with a input and output definitions ----
                sidebarLayout(
                  # Sidebar panel for inputs ----
                  sidebarPanel(
                    
                  ),
                  # Main panel for displaying outputs ----
                  mainPanel(
                    
                  )
                )
       )
       ))
