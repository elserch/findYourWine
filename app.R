#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(forcats)



# load data
wine_reviews <- read.csv("winemag-data_first150k.csv")


# filter all out without price value
all_with_price <- select(filter(wine_reviews, trimws(price) !=""), c(country, points, price, winery, variety))
# add column ratio
all_with_price <- transform(all_with_price, price_points_ratio = price / points)
attach(all_with_price)
all_with_price_sorted <- all_with_price[order(price_points_ratio),]

all_countries <- unique(all_with_price$country)
all_countries_list <- as.list(as.data.frame(t(all_countries)))
all_countries_list <- c("all", all_countries_list)

all_varieties <- unique(all_with_price$variety)
all_varieties_list <- as.list(as.data.frame(t(all_varieties)))
all_varieties_list <- c("all", all_varieties_list)

# Define UI for dataset viewer app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Find your Wine"),
  
  # Sidebar layout with a input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "country",
                  label = "Choose the country of your wine:",
                  choices = c(all_countries_list)),
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "variety",
                  label = "Choose the variety of your wine:",
                  choices = c(all_varieties_list)),
      # Input: Numeric entry for number of obs to view ----
      numericInput(inputId = "minRating",
                   label = "Minimum points to view:",
                   value = 0),
      numericInput(inputId = "maxPrice",
                   label = "Maximum price to view:",
                   value = 2300),
      numericInput(inputId = "obs",
                   label = "Number of observations to view:",
                   value = 10)
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      # Output: HTML table with requested number of observations ----
      tableOutput("view"),
      # Output: Histogram
      plotOutput(outputId = "distPlot"),
      # Output: Verbatim text for data summary ----
      verbatimTextOutput("summary")

    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  table_output <- reactive({
    if (input$country == "all" && input$variety == "all"){
      all_with_price_sorted_output <- select(filter
                                           (all_with_price_sorted, 
                                             points >= input$minRating,
                                             price <= input$maxPrice),
                                           c(country, points, price, price_points_ratio, winery, variety))
    } else if (input$country != "all" && input$variety == "all") {
      all_with_price_sorted_output <- select(filter
                                           (all_with_price_sorted, 
                                             trimws(points) >= input$minRating,
                                             trimws(price) <= input$maxPrice,
                                             trimws(country) == input$country),
                                           c(country, points, price, price_points_ratio, winery, variety))
    } else if (input$country == "all" && input$variety != "all") {
      all_with_price_sorted_output <- select(filter
                                           (all_with_price_sorted, 
                                             trimws(points) >= input$minRating,
                                             trimws(price) <= input$maxPrice,
                                             trimws(variety) == input$variety),
                                           c(country, points, price, price_points_ratio, winery, variety))
    } else {
      all_with_price_sorted_output <- select(filter
                                           (all_with_price_sorted, 
                                             trimws(points) >= input$minRating,
                                             trimws(price) <= input$maxPrice,
                                             trimws(country) == input$country,
                                             trimws(variety) == input$variety),
                                           c(country, points, price, price_points_ratio, winery, variety))
    }
  })
  
  # Generate a summary of the dataset ----
  output$summary <- renderPrint({
    dataset <- table_output()
#    dataset <- count_countries()
    summary(dataset)
  })
   
  # Show the first "n" observations ----
  output$view <- renderTable({
    head(table_output(), n = input$obs)
  })
  
  output$distPlot <- renderPlot({
#    plot_data <- print(ggplot(table_output(), aes(x=country, fill=country))
    plot_data <- print(ggplot(table_output(), aes(x=fct_rev(fct_infreq(country))))
                       + geom_bar(stat = "count"))
    plot_data + coord_flip()
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

