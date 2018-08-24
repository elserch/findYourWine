<<<<<<< HEAD
source("helper.R")

# load data
wine_reviews <- read.csv("winemag-data_first150k.csv")


# filter all out without price value
all_with_price <- select(filter(wine_reviews, trimws(price) !=""), c(country, points, price, winery, variety, designation))
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

# Define server logic
server <- function(input, output) {
  
  ####### REACTIVE #######
  
  table_output_all_data <- reactive({
    all_with_price_sorted_output <- find_wine_by_variety_and_country(
      all_with_price_sorted, input$variety, input$country, input$minRating, input$maxPrice)
  })
  

  
  ######## OUTPUT ########
  
  ######## OUTPUT: Find the most inexpensive wine #######
  output$all_varieties = renderUI({
    selectInput(
      inputId = "variety",
      label = "Choose the variety of your wine:",
      choices = c(all_varieties_list)
    )
  })
  
  output$all_countries = renderUI({
    selectInput(
      inputId = "country",
      label = "Choose the country of your wine:",
      choices = c(all_countries_list)
    )
=======
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
>>>>>>> 0752584b24921702512723152907a95344d8d3ee
  })
  
  # Generate a summary of the dataset ----
  output$summary <- renderPrint({
    dataset <- table_output_all_data()
    summary(dataset)
  })
  
  output$table_all_data <- DT::renderDataTable(DT::datatable({
<<<<<<< HEAD
    table_output_all_data()
  }))
  
  output$distPlot <- renderPlot({
    plot_data <- print(ggplot(table_output_all_data(), aes(x=fct_rev(fct_infreq(country))))
=======
    table_output()
  }))
  
  output$distPlot_count_country <- renderPlot({
    plot_data <- print(ggplot(table_output(), aes(x=fct_rev(fct_infreq(country))))
>>>>>>> 0752584b24921702512723152907a95344d8d3ee
                       + geom_bar(stat = "count"))
    plot_data + coord_flip()
  })

  ######## OUTPUT: Find the wine for your country #######
  
  table_output_summary_varieties <- reactive({
    summary_for_varieties <- summarize_varieties_for_country(all_with_price_sorted, input$country2)
  })
  
  output_country_heatmap <- reactive({
    filtered_for_country <- summarize_for_country_heatmap(all_with_price_sorted, input$country2)
  })
  
  output$all_countries2 = renderUI({
    selectInput(
      inputId = "country2",
      label = "Choose the country of your wine:",
      choices = c(all_countries_list)
    )
  })

  output$table_varieties_for_country <- DT::renderDataTable(DT::datatable({
    table_output_summary_varieties()
  }))  
  
  output$plot <- renderPlot ({
    data_heat <- output_country_heatmap()
    base_size <- 9
    
    ggplot(data = data_heat, aes(x = variety, y = winery)) + 
      geom_tile(aes(fill = mean_price), colour = "white") +
      scale_fill_gradient(low = "white", high = "steelblue") +
      theme_grey(base_size = base_size) +
      labs(x = "", y = "") +
      scale_x_discrete(expand = c(0, 0)) +
      scale_y_discrete(expand = c(0, 0)) +
      theme(legend.position = "none", 
           axis.text.x = element_text(size = base_size * 0.8, angle = 330, hjust = 0, colour = "grey50"))
  })
  
<<<<<<< HEAD
  ######## OUTPUT: Find the countries for your variety #######
  
=======
  output$distPlot_count_variety <- renderPlot({
    plot_data <- print(ggplot(table_output(), aes(x=fct_rev(fct_infreq(variety))))
                       + geom_bar(stat = "count"))
    plot_data + coord_flip()
    
  })
  
  output$table <- renderTable(
    head(variety_output())
  )
>>>>>>> 0752584b24921702512723152907a95344d8d3ee
  
}