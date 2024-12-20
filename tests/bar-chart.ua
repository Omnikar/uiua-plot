# Experimental!
~ "../lib" ~ BarChart Data PlotConfig
[Data!(
    # Data for bar charts should be lists of scalars,
    # rather than lists of coordinates.
    New 2_1_3
    °⊸Label "Ice Cream Sales"
  )
 Data!(
    New 2_2_4
    °⊸Label "Shark Attacks"
  )
 Data!(
    New ¯ 1_2_3
    °⊸Label "Negative Bars"
  )]
PlotConfig!(
  New
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
&ims ⬚∘BarChart
