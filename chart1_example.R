US_pj_rates <- read.csv("us-prison-jail-rates.csv")
  
Los_Angeles_rates <- US_pj_rates %>%
  select(c(fips, year, state, county_name, urbanicity, total_pop, total_prison_pop_rate, black_prison_pop_rate, latinx_prison_pop_rate, white_prison_pop_rate)) %>%
  subset(state == c("CA") & urbanicity == c("urban") & county_name == c("Los Angeles County")) %>%
  filter(year >= c("1995") & year <= c("2015"))

ggplot() +
  geom_line(data = Los_Angeles_rates, aes(x = year, y = black_prison_pop_rate, col = "green"))+
  geom_line(data = Los_Angeles_rates, aes(x = year, y = latinx_prison_pop_rate, col = "blue")) +
  geom_line(data = Los_Angeles_rates, aes(x = year, y = white_prison_pop_rate, col = "red")) +
  labs( title = "Los Angeles County Prisoner Rate (1995-2015)", x = "Year", y = "Population", colour = "Race")


prison_population <- read.csv("us-prison-pop.csv")

filtered_CA_prison_pop <- prison_population %>%
  select(c(fips, year, state, county_name, urbanicity, total_pop, total_prison_pop, black_prison_pop, latinx_prison_pop, white_prison_pop)) %>%
  subset(state == c("CA") & urbanicity == c("urban") & county_name == c("Los Angeles County")) %>%
  filter(year >= c("1995") & year <= c("2015"))

ggplot() +
  geom_line(data = filtered_CA_prison_pop, aes(x = year, y = black_prison_pop, col = "green"))+
  geom_line(data = filtered_CA_prison_pop, aes(x = year, y = latinx_prison_pop, col = "blue")) +
  geom_line(data = filtered_CA_prison_pop, aes(x = year, y = white_prison_pop, col = "red")) +
  labs( title = "Los Angeles County Prisoner Population (1995-2015)", x = "Year", y = "Population", colour = "Race")
