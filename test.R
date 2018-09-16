install.packages("dplyr", dependencies = TRUE)
install.packages("ggplot2")
install.packages("forcats")
install.packages("DT")
install.packages("ggformula")
#install.packages("ddply")

library(ggplot2)
library(dplyr)
library(ggformula)

# load file
wine_reviews <- read.csv("/Users/christianelser/github/findYourWine/winemag-data_first150k.csv")
# filter all out without price value
all_with_price <- select(filter(wine_reviews, trimws(price) !=""), c(country, points, price, variety))
# add column ratio
all_with_price <- transform(all_with_price, price_points_ratio = price / points)
View(all_with_price)
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




SnZ <- aggregate(crime, by = list(Straftat = crime$Straftat, Zeit = crime$time.tag), FUN = length)
names(SnZ) <- c("Straftat", "Zeit", "Count")
ggplot(SnZ, aes(x= Straftat , y= factor(Zeit))) +
  geom_tile(aes(fill= Count)) + 
  scale_x_discrete("Straftat", expand = c(0,0)) +
  scale_y_discrete("Zeitraum", expand = c(0,-2)) +
  scale_fill_gradient("Anzahl Straftaten", low = "gray", high = "red") +
  theme_bw() + 
  ggtitle("Straftaten nach Tageszeit") +
  theme(panel.grid.major = element_line(colour = NA), panel.grid.minor = element_line
        (colour = NA))


library(ggplot2)

#------------------
# CREATE DATA FRAME
#------------------
df.team_data <- expand.grid(teams = c("Team A", "Team B", "Team C", "Team D")
                            ,metrics = c("Metric 1", "Metric 2", "Metric 3", "Metric 4", "Metric 5")
)

# add variable: performance
set.seed(41)
df.team_data$performance <- rnorm(nrow(df.team_data))

#inspect
head(df.team_data)



#---------------------------
# PLOT: heatmap
# - here, we use geom_tile()
#---------------------------

ggplot(data = df.team_data, aes(x = metrics, y = teams)) +
  geom_tile(aes(fill = performance)) 



p + theme_grey(base_size = base_size) 
+ labs(x = "", y = "") + scale_x_discrete(expand = c(0, 0)) 
+ scale_y_discrete(expand = c(0, 0)) 
+ opts(legend.position = "none", axis.ticks = theme_blank(), 
       axis.text.x = theme_text(size = base_size * 0.8, angle = 330, hjust = 0, colour = "grey50"))

plot <- gf_point(price ~ points, data = all_with_price)
View(plot)
