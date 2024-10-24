# This script creates the hex sticker for the `costsplitter` package.
# Dependencies: hexSticker, showtext
library(hexSticker)
library(showtext)
library(rsvg)
library(svglite)
library(ggplot2)



df <- data.frame(
  category = c("A", "B", "C", "D"),
  value = c(10, 20, 30, 40)
)

# Create the pie chart with colors matching the Flatly theme
pie_chart <- ggplot(df, aes(x = "", y = value, fill = category)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  scale_fill_manual(values = c("#18BC9C", "#3498DB", "#F0AD4E", "#8E44AD")) +
  theme_void() +
  theme(legend.position = "none")

# Save the pie chart as an SVG file
ggsave("tools/costsplitter_pie_chart.svg", pie_chart, width = 6, height = 6, dpi = 300, device = "svg")




# Load a custom Google font
font_add_google("Roboto", "roboto")
showtext_auto()

# Generate the hex sticker with the SVG as the subplot
sticker(
  subplot = "tools/costsplitter_pie_chart.svg",
  package = "costsplitter",
  p_color = "#ffffff",
  p_size = 20,
  p_family = "roboto",
  s_x = 1,
  s_y = 0.8,
  s_width = 0.4,  # Adjust the width and height as needed
  s_height = 0.4,
  h_fill = "#2C3E50",  # Background color
  h_color = "#18BC9C", # Border color
  spotlight = FALSE,
  l_x = 1,
  l_y = 1.5,
  l_width = 4,
  l_height = 4,
  l_alpha = 0.3,
  filename = "man/figures/logo.png"
)
