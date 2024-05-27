US_pj_rates <- read.csv("us-prison-jail-rates.csv")

changed_rates <- US_pj_rates %>%
  select(c(fips, year, state, county_name, urbanicity, total_pop, total_prison_pop_rate, black_prison_pop_rate, latinx_prison_pop_rate, white_prison_pop_rate)) %>%
  subset(state == c("CA") & year == ("2015"))

top_10_rates <- changed_rates %>%
  top_n(10, wt = total_pop) %>%
  arrange(total_pop) 
  

ggplot(top_10_rates) + 
  geom_col(
    mapping = aes(x = county_name, y = black_prison_pop_rate, fill = black_prison_pop_rate), position = "dodge") +
    coord_flip() +
  labs( title = "Top 10 Most Populated CA Prisons by County in 2015 (Black Prisoner Rate)", x = "Counties", y = "Population Rate") +
  theme_minimal()
  
