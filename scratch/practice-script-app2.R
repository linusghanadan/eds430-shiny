# load packages ----
library(shiny)
library(palmerpenguins)
library(lterdatasampler)

#............custom ggplot theme (apply to both plots)...........
myCustomTheme <- function() {
  theme_light() +
  theme(axis.text = element_text(size = 12),
        axis.title = element_text(size = 14, face = "bold"),
        legend.title = element_text(size = 14, face = "bold"),
        legend.text = element_text(size = 13),
        legend.position = "bottom",
        panel.border = element_rect(linewidth = 0.7))
}

#.......................wrangle trout data.......................
clean_trout <- and_vertebrates %>% 
  filter(species == "Cutthroat trout") %>% 
  select(sampledate, section, species, length_mm = length_1_mm, weight_g, channel_type = unittype) %>% 
  mutate(channel_type = case_when(
    channel_type == "C" ~ "cascade",
    channel_type == "I" ~ "riffle",
    channel_type =="IP" ~ "isolated pool",
    channel_type =="P" ~ "pool",
    channel_type =="R" ~ "rapid",
    channel_type =="S" ~ "step (small falls)",
    channel_type =="SC" ~ "side channel"
  )) |> 
  mutate(section = case_when(
    section == "CC" ~ "clear cut forest",
    section == "OG" ~ "old growth forest"
  )) %>% 
  drop_na()

#..................practice filtering trout data.................
trout_filtered_df <- clean_trout %>% 
  filter(channel_type %in% c("pool", "rapid")) %>% 
  filter(section %in% c("clear cut forest"))

#........................plot trout data.........................
ggplot(trout_filtered_df, aes(x = length_mm, y = weight_g, color = channel_type, shape = channel_type)) +
  geom_point(alpha = 0.7, size = 5) +
  scale_color_manual(values = c("cascade" = "#2E2585", "riffle" = "#337538", "isolated pool" = "#DCCD7D", 
                                "pool" = "#5DA899", "rapid" = "#C16A77", "step (small falls)" = "#9F4A96", 
                                "side channel" = "#94CBEC")) +
  scale_shape_manual(values = c("cascade" = 15, "riffle" = 17, "isolated pool" = 19, 
                                "pool" = 18, "rapid" = 8, "step (small falls)" = 23, 
                                "side channel" = 25)) +
  labs(x = "Trout Length (mm)", y = "Trout Weight (g)", color = "Channel Type", shape = "Channel Type") +
  myCustomTheme()

#..................practice filtering for island.................
island_df <- penguins %>%
  filter(island %in% c("Dream", "Torgesen"))

#........................plot penguin data.......................
ggplot(na.omit(island_df), aes(x = flipper_length_mm, fill = species)) +
  geom_histogram(alpha = 0.6, position = "identity", bins = 25) +
  scale_fill_manual(values = c("Adelie" = "#FEA346", "Chinstrap" = "#B251F1", "Gentoo" = "#4BA4A4")) +
  labs(x = "Flipper length (mm)", y = "Frequency",
       fill = "Penguin species") +
  myCustomTheme()
