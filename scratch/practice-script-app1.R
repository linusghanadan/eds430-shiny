# load packages ----
library(palmerpenguins)
library(tidyverse)
library(DT)

# filter body masses ----
body_mass_df <- penguins %>% 
  filter(body_mass_g %in% c(3000:4000))

# create scatter plot ----
ggplot(na.omit(body_mass_df),
       aes(x = flipper_length_mm, y = bill_length_mm,
           color = species, shape = species)) +
  geom_point() +
  scale_color_manual(value = c("cornflowerblue", "mediumorchid", "darkorange4")) +
  scale_shape_manual(values = c(19, 17, 15)) +
  labs(x = "Flipper length (mm)",
       y = "Bill length (mm)",
       color = "Penguin species",
       shape = "Penguin species") +
  theme_bw() +
  theme(legend.position = c(0.85, 0.2))

# filter year
year_df <- penguins %>% 
  filter(year %in% c(min(penguins$year), max(penguins$year)))

# show data table for penguins
DT::datatable(year_df)
