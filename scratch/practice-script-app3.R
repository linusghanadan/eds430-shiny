# load pkgs ----
library(tidyverse)
library(leaflet)

# read in data ----
lake_data <- read_csv(here::here("shinydashboard", "data", "lake_data_processed.csv"))

# practice filtering ----
filtered_lakes <- lake_data |>
  filter(Elevation >= 8 & Elevation <= 20) |>
  filter(AvgDepth >= 2 & AvgDepth <= 3) |>
  filter(AvgTemp >= 4 & AvgTemp <= 6)

# build leaflet map ----
leaflet() |>
  addProviderTiles(providers$Esri.WorldImagery) |>
  setView(lng = -152.05, lat = 70.25, zoom = 6) |>
  addMiniMap(toggleDisplay = TRUE, minimized = FALSE) |> 
  addMarkers(data = lake_data,
             lng = lake_data$Longitude,
             lat = lake_data$Latitude,
             popup = paste0(
               "Site Name: ", lake_data$Site, "<br>",
               "Elevation: ", lake_data$Elevation, " meters (above SL)", "<br>",
               "Avg Depth: ", lake_data$AvgDepth, " meters", "<br>",
               "Avg Lake Bed Temperature: ", lake_data$AvgTemp, "\u00B0C"
             ))


