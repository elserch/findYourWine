#library(shiny)
library(dplyr)
library(ggplot2)
library(forcats)
library(DT)



# Define UI for dataset viewer app ----
ui <- fluidPage(navbarPage(title = 'find your wine!',
       tabPanel('Basic Search',
         # Sidebar layout with a input and output definitions ----
         sidebarLayout(
           # Sidebar panel for inputs ----
           sidebarPanel(
             # Irgendwo hier muss ich beschreiben welche Daten ich verwende und welche Arten das sind
             
             # Input: Selector for choosing dataset ----
             selectInput(
               inputId = "country",
               label = "Choose the country of your wine:",
               choices = c(all_countries_list)
             ),
             # Input: Selector for choosing dataset ----
             selectInput(
               inputId = "variety",
               label = "Choose the variety of your wine:",
               choices = c(all_varieties_list)
             ),
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
             DT::dataTableOutput("table"),
             # Output: Histogram
             plotOutput(outputId = "distPlot"),
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
                    
                  ),
                  # Main panel for displaying outputs ----
                  mainPanel(
                    
                  )
                  )),
       tabPanel('Search for Country',
                # Sidebar layout with a input and output definitions ----
                sidebarLayout(
                  # Sidebar panel for inputs ----
                  sidebarPanel(
                    
                  ),
                  # Main panel for displaying outputs ----
                  mainPanel(
                    
                  )

                ))
       ))
