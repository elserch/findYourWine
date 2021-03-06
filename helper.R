#library(dplyr)

find_wine_by_variety_and_country <- function(i_data, i_variety, i_country, i_minRating, i_maxRating, i_minPrice, i_maxPrice) {
  validate(
    need(i_country, 'input missing'),
    need(i_variety, 'input missing')
  )
  if (i_country == "all" && i_variety == "all"){
    all_with_price_sorted_output <- select(filter
                                           (i_data, 
                                             points >= i_minRating,
                                             points <= i_maxRating,
                                             price >= i_minPrice,
                                             price <= i_maxPrice),
                                           c(country, points, price, price_points_ratio, winery, variety))
  } else if (i_country != "all" && i_variety == "all") {
    all_with_price_sorted_output <- select(filter
                                           (i_data, 
                                             points >= i_minRating,
                                             points <= i_maxRating,
                                             price >= i_minPrice,
                                             price <= i_maxPrice,
                                             trimws(country) == i_country),
                                           c(country, points, price, price_points_ratio, winery, variety))
  } else if (i_country == "all" && i_variety != "all") {
    all_with_price_sorted_output <- select(filter
                                           (i_data, 
                                             points >= i_minRating,
                                             points <= i_maxRating,
                                             price >= i_minPrice,
                                             price <= i_maxPrice,
                                             trimws(variety) == i_variety),
                                           c(country, points, price, price_points_ratio, winery, variety))
  } else {
    all_with_price_sorted_output <- select(filter
                                           (i_data, 
                                             points >= i_minRating,
                                             points <= i_maxRating,
                                             price >= i_minPrice,
                                             price <= i_maxPrice,
                                             trimws(country) == i_country,
                                             trimws(variety) == i_variety),
                                           c(country, points, price, price_points_ratio, winery, variety))
  }
  
  return(all_with_price_sorted_output)
}

filter_all_data_for_country <- function(i_data, i_country, i_minPoints, i_maxPoints, i_minPrice, i_maxPrice) {
  validate(
    need(i_country, 'input missing'),
    need(i_country != 'all', 'please choose a country')
  )
  filtered_data <- select(filter
                          (i_data,
                            trimws(country) == i_country,
                            points >= i_minPoints,
                            points <= i_maxPoints,
                            price >= i_minPrice,
                            price <= i_maxPrice),
                          c(country, points, price, price_points_ratio, winery, variety))
  return(filtered_data)
}

summarize_varieties_for_country <- function(i_data, i_country, i_minPoints, i_maxPoints, i_minPrice, i_maxPrice) {
  validate(
    need(i_country, 'input missing'),
    need(i_country != 'all', 'please choose a country')
  )
  if(i_country == 'all') {
    summary <- read.table(text='please choose your country', col.names=('INFO'))
  } else {
    filtered_data <- select(filter
                            (i_data,
                              trimws(country) == i_country,
                              points >= i_minPoints,
                              points <= i_maxPoints,
                              price >= i_minPrice,
                              price <= i_maxPrice),
                            c(country, points, price, price_points_ratio, winery, variety))
    summary_unsorted <- ddply(filtered_data, .(variety), summarize,
                              count=length(variety),
                              mean_price=mean(price), max_price=max(price), min_price=min(price), 
                              mean_points=mean(points), max_points=max(points), min_points=min(points))
    attach(summary_unsorted)
    summary <- summary_unsorted[order(-count),]
  }
  
  return(summary)
}

summarize_for_country_heatmap <- function(i_data, i_country, i_minPoints, i_maxPoints, i_minPrice, i_maxPrice) {
  validate(
    need(i_country, 'input missing'),
    need(i_country != 'all', 'please choose a country')
  )
  if(i_country == 'all') {
    summary <- read.table(text='please choose your country', col.names=('INFO'))
  } else {
    filtered_data <- select(filter
                            (i_data,
                              trimws(country) == i_country,
                              points >= i_minPoints,
                              points <= i_maxPoints,
                              price >= i_minPrice,
                              price <= i_maxPrice),
                            c(country, points, price, price_points_ratio, winery, variety))
    summary_unsorted <- ddply(filtered_data, .(variety, winery), summarize,
                              count_variety=length(variety), count_winery=length(winery),
                              mean_price=mean(price), max_price=max(price), min_price=min(price), 
                              mean_points=mean(points), max_points=max(points), min_points=min(points))
    attach(summary_unsorted)
    summary <- summary_unsorted[order(-count),]
  }
  
  return(summary)
}



summarize_countries_for_variety <- function(i_data, i_variety, i_minPoints, i_maxPoints, i_minPrice, i_maxPrice) {
  validate(
    need(i_variety, 'input missing'),
    need(i_variety != 'all', 'please choose a variety')
  )
  if(i_variety == 'all') {
    summary <- read.table(text='please choose your Variety', col.names=('INFO'))
  } else {
    filtered_data <- select(filter
                            (i_data,
                              trimws(variety) == i_variety,
                              points >= i_minPoints,
                              points <= i_maxPoints,
                              price >= i_minPrice,
                              price <= i_maxPrice),
                            c(country, variety, points, price, price_points_ratio, winery, variety))
    summary_unsorted <- ddply(filtered_data, .(country), summarize,
                              count=length(country),
                              mean_price=mean(price), max_price=max(price), min_price=min(price), 
                              mean_points=mean(points), max_points=max(points), min_points=min(points))
    attach(summary_unsorted)
    summary <- summary_unsorted[order(-count),]
  }
  
  return(summary)
}

spearman <- function(i_data) {
  spearman <- cor(i_data$price, i_data$points, method="spearman")
}

pearson <- function(i_data) {
  pearson <- cor(i_data$price, i_data$points, method="pearson")
}

# calculate_correlation <- function(i_data, x, y) {
#   cor_value <- cor(i_data$x, i_data$y)
# }

filter_all_data_for_variety <- function(i_data, i_variety, i_minPoints, i_maxPoints, i_minPrice, i_maxPrice) {
  validate(
    need(i_variety, 'input missing'),
    need(i_variety != 'all', 'please choose a variety')
  )
  filtered_data <- select(filter
                          (i_data,
                            trimws(variety) == i_variety,
                            points >= i_minPoints,
                            points <= i_maxPoints,
                            price >= i_minPrice,
                            price <= i_maxPrice),
                          c(country, points, price, price_points_ratio, winery, variety))
  return(filtered_data)
}
