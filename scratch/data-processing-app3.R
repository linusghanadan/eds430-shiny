# load pkgs ----
library(tidyverse)

# read in raw data ----
lake_raw <- read_csv(here::here("raw-data", "FCWO_lakemonitoringdata_2011_2022_daily.csv"))

# avg depth and temp ----
avg_depth_temp <- lake_raw %>% 
  select(Site, Depth, BedTemperature) %>% 
  filter(Depth != "NaN") %>% 
  drop_na(BedTemperature) %>% 
  group_by(Site) %>% 
  summarize(
    AvgDepth = round(mean(Depth), 1),
    AvgTemp = round(mean(BedTemperature), 1)
  )

# joined dfs together ----
joined_dfs <- full_join(lake_raw, avg_depth_temp)

# unique lakes ----
unique_lakes <- joined_dfs %>% 
  select(Site, Latitude, Longitude, Elevation, AvgDepth, AvgTemp) %>% 
  distinct()

# save processed data ----
write_csv(unique_lakes, file = here::here("shinydashboard", "data", "lake_data_processed.csv"))
