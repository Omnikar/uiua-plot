# uiua-plot

`uiua-plot` is a data plotting library for the [Uiua](https://uiua.org) programming language.

The library requires `# Experimental!` due to reliance on the `layout` function for text rendering, reliance on [`uiua-math`](https://github.com/Omnikar/uiua-math), and internal usage of experimental modifiers.

To create a plot, you first need to make a `PlotConfig`. This can be done in two main ways.

If you just want to get straight to plotting data, you can just create a new `PlotConfig`, which is initialized with some default values.
```uiua
# Experimental!
~ "git: github.com/Omnikar/uiua-plot" ~ PlotConfig
PlotConfig
```
On the other hand, if you want to configure how your plot is drawn, you can use a builder pattern as follows. Note that the current functionality of the `S!` macro will be replaced by `°⊸` in the near future.
```uiua
# Experimental!
~ "git: github.com/Omnikar/uiua-plot" ~ PlotConfig S!
PlotConfig!(
  New
  # Minimum x and y bounds
  S!Min 2006.8_¯0.3
  # Maximum x and y bounds
  S!Max 2009.2_4.3
  # Spacing between gridlines in the x and y directions
  S!GridlineInterval 0.5_1
  # Size of the image to produce
  S!Size 800_400
  # Color(s) to use for plotting the data
  S!PlotColor [0.33_0.51_0.93 0.85_0.32_0.25]
  # Whether to draw dots or not
  S!DrawDots 0
)
```

Once you have a `PlotConfig`, you can use it to plot some data with the `Plot` function. This function can take a single `N×2` array to plot one data series of N entries, or it can take a box list of such arrays to plot multiple data series.
```uiua
# Experimental!
~ "git: github.com/Omnikar/uiua-plot" ~ Plot PlotConfig S!
PlotConfig!(
  New
  # Minimum x and y bounds
  S!Min 2006.8_¯0.3
  # Maximum x and y bounds
  S!Max 2009.2_4.3
  # Spacing between gridlines in the x and y directions
  S!GridlineInterval 0.5_1
  # Size of the image to produce
  S!Size 800_400
  # Color(s) to use for plotting the data
  S!PlotColor [0.33_0.51_0.93 0.85_0.32_0.25]
  # Whether to draw dots or not
  S!DrawDots 0
)

&ims Plot {
  [2007_2 2008_1 2009_3]
  [2007_2 2008_2 2009_4]}
```
This code produces the following output ([try it online](https://www.uiua.org/pad?src=0_13_0-dev_2__IyBFeHBlcmltZW50YWwhCn4gImdpdDogZ2l0aHViLmNvbS9PbW5pa2FyL3VpdWEtcGxvdCIgfiBQbG90IFBsb3RDb25maWcgUyEKUGxvdENvbmZpZyEoCiAgTmV3CiAgIyBNaW5pbXVtIHggYW5kIHkgYm91bmRzCiAgUyFNaW4gMjAwNi44X8KvMC4zCiAgIyBNYXhpbXVtIHggYW5kIHkgYm91bmRzCiAgUyFNYXggMjAwOS4yXzQuMwogICMgU3BhY2luZyBiZXR3ZWVuIGdyaWRsaW5lcyBpbiB0aGUgeCBhbmQgeSBkaXJlY3Rpb25zCiAgUyFHcmlkbGluZUludGVydmFsIDAuNV8xCiAgIyBTaXplIG9mIHRoZSBpbWFnZSB0byBwcm9kdWNlCiAgUyFTaXplIDgwMF80MDAKICAjIENvbG9yKHMpIHRvIHVzZSBmb3IgcGxvdHRpbmcgdGhlIGRhdGEKICBTIVBsb3RDb2xvciBbMC4zM18wLjUxXzAuOTMgMC44NV8wLjMyXzAuMjVdCiAgIyBXaGV0aGVyIHRvIGRyYXcgZG90cyBvciBub3QKICBTIURyYXdEb3RzIDAKKQoKJmltcyBQbG90IHsKICBbMjAwN18yIDIwMDhfMSAyMDA5XzNdCiAgWzIwMDdfMiAyMDA4XzIgMjAwOV80XX0K)):
![Example plot](examples/example-plot-0.png)

If unspecified, plot bounds and gridline spacing are inferred, and a default selection of colors is used.
```uiua
# Experimental!
~ "git: github.com/Omnikar/uiua-plot" ~ Plot PlotConfig
PlotConfig
&ims Plot {
  [2007_2 2008_1 2009_3]
  [2007_2 2008_2 2009_4]}
```
![Example plot without configuration](examples/example-plot-1.png)

Fields supporting inference actually have their values default to `[∞ ∞]`, and these are replaced with inferred values when `Plot` is called. If you want, you can take advantage of this to partially infer some fields, for example by setting `Max` to `[10 ∞]` to use an upper bound of `10` in the x direction, but infer the upper bound in the y direction.

All available configuration values for `PlotConfig` are in the following table. Any field marked with "Distributive" will distribute its values across multiple data series, cycling if necessary.
| Field | Shape | Description | Default |
|---|---|---|---|
| `Min` | `[2]` | The minimum x and y bounds of the plot | Inferred |
| `Max` | `[2]` | The maximum x and y bounds of the plot | Inferred |
| `Size` | `[2]` | The pixel dimensions of the image to output | `[512 512]` |
| `BgColor` | `[3]` or `[4]` | Plot background color | `[1 1 1]` |
| `AxisWidth` | `[]` | Thickness of the main axes | `3` |
| `AxisColor` | `[3]` or `[4]` | Color of the main axes | `[0 0 0]` |
| `GridlineWidth` | `[]` | Thickness of the gridlines | `1` |
| `GridlineColor` | `[3]` or `[4]` | Color of the gridlines | `[0.7 0.7 0.7]` |
| `GridlineInterval` | `[2]` | Spacing between gridlines in the x and y directions | Inferred |
| `NumberSize` | `[]` | Font size to use for axis numbers | `15` |
| `NumberColor` | `[3]` or `[4]` | Font color to use for axis numbers | `[0.3 0.3 0.3]` |
| `XLabel` | string | x-axis label | `""` |
| `YLabel` | string | y-axis label | `""` |
| `LabelSize` | `[]` | Font size to use for axis labels | `20` |
| `LabelColor` | `[3]` or `[4]` | Font color to use for axis labels | `[0.2 0.2 0.2]` |
| `PlotColor` | `[3]`, `[4]`, `[x 3]`, or `[x 4]` | (Distributive) Colors with which to plot data series | [Desmos graph colors](https://www.desmos.com/api/v1.7/docs/index.html#document-colors) |
| `DrawDots` | `[]` or `[x]` | (Distributive) Whether to draw dots when plotting a series; expects `0` or `1` | `1` |
| `DotSize` | `[]` or `[x]` | (Distributive) Size with which to draw dots | `40` |
| `DrawLines` | `[]` or `[x]` | (Distributive) Whether to draw lines when plotting a series; expects `0` or `1` | `1` |
| `LineWidth` | `[]` or `[x]` | (Distributive) Thickness with which to draw lines | `8` |
