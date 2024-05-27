library(dplyr)
library(tidyverse)
library(ggplot2)
library(ggmap)

US_pj_rates <- read.csv("us-prison-jail-rates.csv")

select_rates <- US_pj_rates %>%
  select(c(fips, year, state, county_name, urbanicity, black_prison_pop_rate, latinx_prison_pop_rate, white_prison_pop_rate))

filtered_select_rates <- select_rates %>%
  subset(year == c("2015") & state == c("CA"))
  
CA_counties_data <- filtered_select_rates %>%
  mutate(county_name = gsub("County", " ", filtered_select_rates$county_name)) %>%
  mutate(county_name = tolower(county_name))

counties_USA <- map_data("county") 

CA_map <- filter(counties_USA, region == "california")

CA_counties <- CA_map %>% 
  rename(county_name = subregion)
  
joined_CA_counties <- left_join(CA_counties, CA_counties_data, by = "county_name") 

top_3_BP <- filtered_select_rates %>%
  top_n(3, wt = black_prison_pop_rate) %>%
  arrange(black_prison_pop_rate)

BP_Rates <- data.frame(
  county = c("Tehama County", "Lake County", "Shasta County"),
  lat = c(40.46801, 38.93248, 41.20139),
  long = c(-121.5014, -122.4010, -121.4670)
)
 
ggplot(joined_CA_counties) +
   geom_polygon(mapping = aes(x = long, y = lat, group = group)) +
   geom_point(
     data = BP_Rates,
     mapping = aes(x = long, y = lat),
     color = "red"
   ) +
   coord_map() +
  labs( title = "Top 3 CA Counties With Highest Black Prisoner Rate (2015)")
