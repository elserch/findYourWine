source('helper.R')

# Define server logic
server <- function(input, output) {
  # reactive table dataset
  table_output <- reactive({
    filter_by_country_variety_minRating_maxPrice(input$country, input$variety, input$minRating, input$maxPrice)
  })
  
  # reactive filter options
  variety_output <- reactive({
    find_all_unique_varieties_by_country(input$country_by_variety)
  })
  
  output$variableUI <- renderUI({
    selectInput(inputId = "input$variety_by_variety", label = "Choose the variety of your wine pending on the country:", choices = variety_output())
  })
  
  # Generate a summary of the dataset ----
  output$summary <- renderPrint({
    dataset <- table_output()
    summary(dataset)
  })
  
  output$table_all_data <- DT::renderDataTable(DT::datatable({
    table_output()
  }))
  
  output$distPlot_count_country <- renderPlot({
    plot_data <- print(ggplot(table_output(), aes(x=fct_rev(fct_infreq(country))))
                       + geom_bar(stat = "count"))
    plot_data + coord_flip()
    
  })
  
  output$distPlot_count_variety <- renderPlot({
    plot_data <- print(ggplot(table_output(), aes(x=fct_rev(fct_infreq(variety))))
                       + geom_bar(stat = "count"))
    plot_data + coord_flip()
    
  })
  
  output$table <- renderTable(
    head(variety_output())
  )
  
}