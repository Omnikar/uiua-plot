- Modify readme to reflect optional arg shorthand for plot-generating functions.

## QoL
- Improve performance/memory usage of SDF line rendering

## Features
- Separate backend from abstract frontend? Like produce a structured arrangement of `Layer` instances that is then rendered by the image rendering stuff. This would allow for implementing custom render frontends, like with raylib.
- Bar width inference for bar charts
- Config option for whether to display axis numbers?
- Support for minor gridlines by passing higher rank arrays to `GridlineInterval`, `GridlineWidth`, and `GridlineColor`?
- Give axis numbers backdrops so that they can be seen when intersecting with axes/gridlines?
- Convenient interface for harnessing the lib's modularity capabilities and making more custom chart configurations.
  - Manually combining `Axes`, `Gridlines`, `SingleSeries`, etc.

- Make histogram and bar chart numbers render outside the chart
- Variadic `Func!`?

## Bugs
- Histogram bars do not align properly with the gridlines.
- Error if a data series is empty or entirely out of bounds of the plot
- Error if only one point of a series is being considered (including cases where a series has only one point) and a line draw is attempted
- When plot bounds are partially specified, the inference of the remaining bounds still takes into account data points that lie outside of the specified bounds.
- Inference of gridline intervals does not account for manually configured plot bounds
- Inference does not work if there is only one data point
- Error if a single label in the legend is too long to fit on one line
