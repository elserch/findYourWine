install.packages("dplyr")
install.packages("ggplot2")
install.packages("forcats")
install.packages("DT")
library(ggplot2)
library(dplyr)

# load file
wine_reviews <- read.csv("****/winemag-data_first150k.csv")
# filter all out without price value
all_with_price <- select(filter(wine_reviews, trimws(price) !=""), c(country, points, price, variety))
# add column ratio
all_with_price <- transform(all_with_price, price_points_ratio = price / points)
View(all_with_price).rd
# get average points per country
average_points_country <- all_with_price %>% group_by(country) %>% summarise(mean_points = mean(points))
View(average_points_country)
average_points_country_variety <- all_with_price %>% group_by(.dots=c("country", "variety")) %>% summarize(mean_points = mean(points))
View(average_points_country_variety)
average_price_points_ratio_country_variety <- all_with_price %>% group_by(.dots=c("country", "variety")) %>% summarize(mean_price_points_ratio  = mean(price_points_ratio ))
View(average_points_country_variety)
all_countries <- unique(all_with_price$country) 
View(all_countries)
all_countries_count <- table(all_with_price$country)
View(all_countries_count)
all_countries_list <- as.list(as.data.frame(t(all_countries)))
View(all_countries_list)

all_with_price_sorted <- all_with_price[order(price_points_ratio),]
all_with_price_output <- select(filter(all_with_price, trimws(points) < 91), c(country, points, price, price_points_ratio, variety))
View(all_with_price_output)


