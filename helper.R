library(plyr)

find_wine_by_variety_and_country <- function(i_data, i_variety, i_country, i_minRating, i_maxPrice) {
  validate(
    need(i_country, 'input missing'),
    need(i_variety, 'input missing')
  )
  if (i_country == "all" && i_variety == "all"){
    all_with_price_sorted_output <- select(filter
                                           (i_data, 
                                             points >= i_minRating,
                                             price <= i_maxPrice),
                                           c(country, points, price, price_points_ratio, winery, variety, designation))
  } else if (i_country != "all" && i_variety == "all") {
    all_with_price_sorted_output <- select(filter
                                           (i_data, 
                                             trimws(points) >= i_minRating,
                                             trimws(price) <= i_maxPrice,
                                             trimws(country) == i_country),
                                           c(country, points, price, price_points_ratio, winery, variety, designation))
  } else if (i_country == "all" && i_variety != "all") {
    all_with_price_sorted_output <- select(filter
                                           (i_data, 
                                             trimws(points) >= i_minRating,
                                             trimws(price) <= i_maxPrice,
                                             trimws(variety) == i_variety),
                                           c(country, points, price, price_points_ratio, winery, variety, designation))
  } else {
    all_with_price_sorted_output <- select(filter
                                           (i_data, 
                                             trimws(points) >= i_minRating,
                                             trimws(price) <= i_maxPrice,
                                             trimws(country) == i_country,
                                             trimws(variety) == i_variety),
                                           c(country, points, price, price_points_ratio, winery, variety, designation))
  }
  
  return(all_with_price_sorted_output)
}

summarize_varieties_for_country <- function(i_data, i_country) {
  validate(
    need(i_country, 'input missing')
  )
  if(i_country == 'all') {
    summary <- read.table(text='please choose your country', col.names=('INFO'))
  } else {
    filtered_data <- select(filter
                            (i_data,
                              trimws(country) == i_country),
                            c(country, points, price, price_points_ratio, winery, variety, designation))
    summary_unsorted <- ddply(filtered_data, .(variety), summarize,
                     count=length(variety),
                     mean_price=mean(price), max_price=max(price), min_price=min(price), 
                     mean_points=mean(points), max_points=max(points), min_points=min(points))
    attach(summary_unsorted)
    summary <- summary_unsorted[order(-count),]
  }
  
  return(summary)
}

summarize_for_country_heatmap <- function(i_data, i_country) {
  validate(
    need(i_country, 'input missing')
  )
  if(i_country == 'all') {
    summary <- read.table(text='please choose your country', col.names=('INFO'))
  } else {
    filtered_data <- select(filter
                            (i_data,
                              trimws(country) == i_country),
                            c(country, points, price, price_points_ratio, winery, variety, designation))
    summary_unsorted <- ddply(filtered_data, .(variety, winery), summarize,
                              count_variety=length(variety), count_winery=length(winery),
                              mean_price=mean(price), max_price=max(price), min_price=min(price), 
                              mean_points=mean(points), max_points=max(points), min_points=min(points))
    attach(summary_unsorted)
    summary <- summary_unsorted[order(-count),]
  }
  
  return(summary)
}
