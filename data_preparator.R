# load data
wine_reviews <- read.csv("winemag-data_first150k.csv")
# filter all out without price value
all_with_price <- select(filter(load_data(), trimws(price) !=""), c(country, points, price, winery, variety, designation))
# filter duplicates
all_with_price_no_duplicates <- distinct(all_with_price)
# add column ratio
all_with_price_no_duplicates <- transform(filter_data(), price_points_ratio = round(price / points, digits = 4))
attach(all_with_price_no_duplicates)
prepared_data <- all_with_price_no_duplicates[order(price_points_ratio),]

