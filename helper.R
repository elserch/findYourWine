<<<<<<< HEAD
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
=======
# function to load data from file
load_data <- function() {
  # load data
  return(wine_reviews <- read.csv("winemag-data_first150k.csv"))
}

# function to filter out rows without price and duplicates
filter_data <- function() {
  # filter all out without price value
  all_with_price <- select(filter(load_data(), trimws(price) !=""), c(country, points, price, winery, variety, designation))
  # filter duplicates
  return(all_with_price_no_duplicates <- distinct(all_with_price))
}

# function to calculate a price/points ratio which is the most important decision criteria
# sort the data by this new column
calculate_price_points_ratio <- function() {
  # add column ratio
  all_with_price_no_duplicates <- transform(filter_data(), price_points_ratio = round(price / points, digits = 4))
  attach(all_with_price_no_duplicates)
  return(all_with_price_sorted <- all_with_price_no_duplicates[order(price_points_ratio),])
}

# function to create a list of all unique available countries
find_all_unique_countries <- function() {
  all_countries <- unique(filter_data()$country)
  all_countries_list <- as.list(as.data.frame(t(all_countries)))
  return(all_countries_list <- c("all", all_countries_list))
}

# function to create a list of all unique available varieties
find_all_unique_varieties <- function() {
  all_varieties <- unique(filter_data()$variety)
  all_varieties_list <- as.list(as.data.frame(t(all_varieties)))
  return(all_varieties_list <- c("all", all_varieties_list))
}

# function to create a list of all unique available varieties
find_all_unique_varieties_by_country <- function(i_country) {
  all_with_price_filter_by_country <- filter(all_with_price_no_duplicates, country==i_country)
  all_with_price_filter_by_country <- unique(all_with_price_filter_by_country$variety)
  all_varieties_list_by_country <- as.list(as.data.frame(t(all_with_price_filter_by_country)))
  return(all_varieties_list_by_country <- c("all", all_varieties_list_by_country))
}

# function to filter via input criteria
filter_by_country_variety_minRating_maxPrice <- function(i_country, i_variety, i_min_rating, i_max_price) {
  if (i_country == "all" && i_variety == "all"){
    all_with_price_sorted_output <- select(filter
                                           (calculate_price_points_ratio(), 
                                             points >= i_min_rating,
                                             price <= i_max_price),
                                           c(country, points, price, price_points_ratio, winery, variety, designation))
  } else if (i_country != "all" && i_variety == "all") {
    all_with_price_sorted_output <- select(filter
                                           (calculate_price_points_ratio(), 
                                             trimws(points) >= i_min_rating,
                                             trimws(price) <= i_max_price,
>>>>>>> 0752584b24921702512723152907a95344d8d3ee
                                             trimws(country) == i_country),
                                           c(country, points, price, price_points_ratio, winery, variety, designation))
  } else if (i_country == "all" && i_variety != "all") {
    all_with_price_sorted_output <- select(filter
<<<<<<< HEAD
                                           (i_data, 
                                             trimws(points) >= i_minRating,
                                             trimws(price) <= i_maxPrice,
=======
                                           (calculate_price_points_ratio(), 
                                             trimws(points) >= i_min_rating,
                                             trimws(price) <= i_max_price,
>>>>>>> 0752584b24921702512723152907a95344d8d3ee
                                             trimws(variety) == i_variety),
                                           c(country, points, price, price_points_ratio, winery, variety, designation))
  } else {
    all_with_price_sorted_output <- select(filter
<<<<<<< HEAD
                                           (i_data, 
                                             trimws(points) >= i_minRating,
                                             trimws(price) <= i_maxPrice,
=======
                                           (calculate_price_points_ratio(), 
                                             trimws(points) >= i_min_rating,
                                             trimws(price) <= i_max_price,
>>>>>>> 0752584b24921702512723152907a95344d8d3ee
                                             trimws(country) == i_country,
                                             trimws(variety) == i_variety),
                                           c(country, points, price, price_points_ratio, winery, variety, designation))
  }
<<<<<<< HEAD
  
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
=======
}

>>>>>>> 0752584b24921702512723152907a95344d8d3ee

