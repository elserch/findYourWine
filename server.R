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
  
  table_output <- reactive({
    if (input$country == "all" && input$variety == "all"){
      all_with_price_sorted_output <- select(filter
                                             (all_with_price_sorted, 
                                               points >= input$minRating,
                                               price <= input$maxPrice),
                                             c(country, points, price, price_points_ratio, winery, variety, designation))
    } else if (input$country != "all" && input$variety == "all") {
      all_with_price_sorted_output <- select(filter
                                             (all_with_price_sorted, 
                                               trimws(points) >= input$minRating,
                                               trimws(price) <= input$maxPrice,
                                               trimws(country) == input$country),
                                             c(country, points, price, price_points_ratio, winery, variety, designation))
    } else if (input$country == "all" && input$variety != "all") {
      all_with_price_sorted_output <- select(filter
                                             (all_with_price_sorted, 
                                               trimws(points) >= input$minRating,
                                               trimws(price) <= input$maxPrice,
                                               trimws(variety) == input$variety),
                                             c(country, points, price, price_points_ratio, winery, variety, designation))
    } else {
      all_with_price_sorted_output <- select(filter
                                             (all_with_price_sorted, 
                                               trimws(points) >= input$minRating,
                                               trimws(price) <= input$maxPrice,
                                               trimws(country) == input$country,
                                               trimws(variety) == input$variety),
                                             c(country, points, price, price_points_ratio, winery, variety, designation))
    }
  })
  
  # Generate a summary of the dataset ----
  output$summary <- renderPrint({
    dataset <- table_output()
    summary(dataset)
  })
  
  output$table <- DT::renderDataTable(DT::datatable({
    table_output()
  }))
  
  output$distPlot <- renderPlot({
    plot_data <- print(ggplot(table_output(), aes(x=fct_rev(fct_infreq(country))))
                       + geom_bar(stat = "count"))
    plot_data + coord_flip()
    
  })
  
}