x_values <- seq(1, 3)
y_values <- seq(1,3)

library(dplyr)
library(tidyverse)
library(ggplot2)

prison_population <- read.csv("us-prison-pop.csv")

select_prison_pop <- select(prison_population, c(fips, year, state, county_name, urbanicity, total_pop, total_prison_pop, black_prison_pop, latinx_prison_pop, native_prison_pop, white_prison_pop))

CA_prison_pop <- filter(select_prison_pop, state == c("CA")) 
CA_prison_pop <-  arrange(CA_prison_pop, county_name) 
  
FL_prison_pop <- filter(select_prison_pop, state == c("FL")) 
FL_prison_pop <- arrange(FL_prison_pop, county_name) 
  
new_prison_pop <- full_join(FL_prison_pop, CA_prison_pop)

filtered_CA_prison_pop <- subset(CA_prison_pop, urbanicity == c("urban") & county_name == c("Los Angeles County"))
  filtered_CA_prison_pop <- filter(filtered_CA_prison_pop, year >= c("1990") & year <= c("2015")) 

filtered_FL_prison_pop <- filter(FL_prison_pop, urbanicity == c("urban") & county_name == c("Miami-Dade County"))
filtered_FL_prison_pop <- filter(filtered_FL_prison_pop, year >= c("1990") & year <= c("2015")) 


ggplot(filtered_CA_prison_pop, aes(x = year, y = black_prison_pop, col = "red")) +
  geom_line() +
  geom_point() + 
  geom_smooth() + 
labs( title = "Change in BIPOC Prisoners from (1990-2015)", x = "Year", y = "Population")

ggplot(filtered_FL_prison_pop, aes(x = year, y = black_prison_pop, col = "red")) +
  geom_line() +
  geom_point() + 
  geom_smooth() + 
  labs( title = "Change in BIPOC Prisoners from 1990-2015", x = "Year", y = "Population")



