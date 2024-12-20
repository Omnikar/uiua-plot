# Experimental!
~ "../lib" ~ Data Line Plot PlotConfig
[Data!(
    Line [2007_2 2008_1 2009_3]
    # Color to draw the plot
    °⊸Color 0.33_0.51_0.93
    # Label to use in the plot legend
    °⊸Label "Ice Cream Sales"
  )
 Data!(
    Line [2007_2 2008_2 2009_4]
    °⊸Color 0.85_0.32_0.25
    °⊸Label "Shark Attacks"
  )]
PlotConfig!(
  New
  # Minimum and maximum x bounds
  °⊸XBounds 2006.9_2009.1
  # Minimum and maximum y bounds
  °⊸YBounds ¯0.3_4.3
  # Spacing between gridlines in the x and y directions
  °⊸GridlineInterval 0.5_1
  # Size of the image to produce
  °⊸Size 800_400
  # Label of the x-axis
  °⊸XLabel "Year"
)
&ims ⬚∘Plot
