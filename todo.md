## Features
- Legend?
- Config option for whether to display axis numbers
- Support for minor gridlines by passing higher rank arrays to `GridlineInterval`, `GridlineWidth`, and `GridlineColor`
- Give axis numbers backdrops so that they can be seen when intersecting with axes/gridlines?
- Function plotter integration?

## Bugs
- Error if a data series is empty or entirely out of bounds of the plot
- Error if only one point of a series is being considered (including cases where a series has only one point) and a line draw is attempted
- When plot bounds are partially specified, the inference of the remaining bounds still takes into account data points that lie outside of the specified bounds.
- Inference does not work if there is only one data point
