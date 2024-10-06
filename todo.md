## Features
- Axis labels
- Legend?
- Config option for whether to display axis numbers
- Support for minor gridlines by passing higher rank arrays to `GridlineInterval`, `GridlineWidth`, and `GridlineColor`

## Bugs
- When drawing lines, out-of-bounds points are taken completely out of consideration, and visible points that should connect to them connect to each other instead.
- Error if a data series is entirely out of bounds of the plot
- Error if only one point of a series is being considered and a line draw is attempted
