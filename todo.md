## Features
- Axis labels
- Legend?
- Config option for whether to display axis numbers
- Support for minor gridlines by passing higher rank arrays to `GridlineInterval`, `GridlineWidth`, and `GridlineColor`

## Bugs
- Error if a data series is empty or entirely out of bounds of the plot
- Error if only one point of a series is being considered (including cases where a series has only one point) and a line draw is attempted
