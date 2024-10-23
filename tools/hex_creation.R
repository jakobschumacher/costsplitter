# This script creates the hex sticker for the `costsplitter` package.
# Dependencies: hexSticker, showtext
library(hexSticker)
library(showtext)
library(rsvg)

# Load a custom Google font
font_add_google("Roboto", "roboto")
showtext_auto()

# Path to the SVG subplot used in the sticker
svg_path <- "tools/icon.svg"  # Ensure this path is correct and points to your SVG

# Generate the hex sticker with the SVG as the subplot
sticker(
  subplot = svg_path,
  package = "costsplitter",
  p_color = "#ffffff",
  p_size = 20,
  p_family = "roboto",
  s_x = 1,
  s_y = 0.8,
  s_width = 0.8,  # Adjust the width and height as needed
  s_height = 0.8,
  h_fill = "#0073C2",  # Background color
  h_color = "#003B73", # Border color
  spotlight = TRUE,
  l_x = 1,
  l_y = 1.5,
  l_width = 4,
  l_height = 4,
  l_alpha = 0.3,
  filename = "costsplitter_hex.png"  # Save as SVG for high quality
)
