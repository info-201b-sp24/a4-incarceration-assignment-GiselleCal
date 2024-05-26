library(dplyr)
library(tidyverse)
library(ggplot2)

US_pj_rates <- read.csv("us-prison-jail-rates.csv")

select_rates <- select(US_pj_rates, c(fips, year, state, county_name, urbanicity, black_prison_pop_rate, latinx_prison_pop_rate, white_prison_pop_rate))

filtered_select_rates <- select_rates %>%
  subset(year == c("2015") & state == c("CA")) %>%
  
CA_counties_data <- mutate(filtered_select_rates, county_name = gsub("County", " ", filtered_select_rates$county_name))

counties_USA <- map_data("county") 

CA_map <- filter(counties_USA, region == "california")

ggplot(CA_map) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group),
    color = "white",
    size = .1
  ) +
  coord_map()

CA_counties <- CA_map %>% 
  rename(county_name = subregion) %>%
  right_join(CA_counties_data, by = "county_name") 