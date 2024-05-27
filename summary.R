library(tidyverse)
library(dplyr)

US_pj_rates <- read.csv("us-prison-jail-rates.csv")

"What is the average value of black_prison_pop_rate, white_prison_pop_rate, latine_prison_pop_rate across all the counties in CA (in 2015)?"

select_rates <- US_pj_rates %>%
  select(c(fips, year, state, county_name, urbanicity, black_prison_pop_rate, latinx_prison_pop_rate, white_prison_pop_rate))

filtered_select_rates <- select_rates %>%
  subset(year == c("2015") & state == c("CA"))

mean(filtered_select_rates$black_prison_pop_rate, na.rm = TRUE)
mean(filtered_select_rates$latinx_prison_pop_rate, na.rm = TRUE)
mean(filtered_select_rates$white_prison_pop_rate, na.rm = TRUE)

"What is black_prison_pop_rate the highest in CA in 1995 and 2015?" 

select_rates_1995 <- select_rates %>%
  subset(year == c("1995") & state == c("CA"))

"1995"

max(select_rates_1995$black_prison_pop_rate, na.rm = TRUE)

"2015"

max(filtered_select_rates$black_prison_pop_rate, na.rm = TRUE)


"What is black_prison_pop_rate the lowest in CA in 1995 and 2015?"

"1995"

min(select_rates_1995$black_prison_pop_rate, na.rm = TRUE)

"2015"

min(filtered_select_rates$black_prison_pop_rate, na.rm = TRUE)


"Which urbanicities had the highest rate of latinx and black prisoners rate in CA in 2015?" 

filtered_select_rates %>%
  top_n(1, wt = black_prison_pop_rate) %>%
  select("urbanicity")

filtered_select_rates %>%
  top_n(1, wt = latinx_prison_pop_rate) %>%
  select("urbanicity")

"What was the variable with the largest rate over all the counties in CA in 2015?" 
