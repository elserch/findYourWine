library(ggplot2)
library(forcats)
library(DT)
#library(plotly)


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
