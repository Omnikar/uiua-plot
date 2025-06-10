# Experimental!
~ "../lib" ~ BarChart! Data
⇌Data!↓[
  # Data for bar charts should be lists of scalars,
  # rather than lists of coordinates.
  New 2_1_3
  °⊸Label "Ice Cream Sales"

  New 2_2_4
  °⊸Label "Shark Attacks"

  New ¯ 1_2_3
  °⊸Label "Negative Bars"
]

BarChart!(
  # Size of the image to produce
  °⊸Size 512_400
  # Gridline spacing in the y direction
  °⊸(⊣GridlineInterval) 1
  # Label of the x-axis
  °⊸XLabel "Year"
  # Label of the y-axis
  °⊸YLabel "Quantity"
  # Labels for each bar cluster
  °⊸BarLabels {"2007" "2008" "2009"}
)
&ims
