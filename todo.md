## Features
- Inference of some `PlotConfig` values, such as plot bounds
- Axis labels
- Legend?
- Config option for whether to display axis numbers

## Bugs
- When drawing lines, out-of-bounds points are taken completely out of consideration, and visible points that should connect to them connect to each other instead.
- Error if a data series is entirely out of bounds of the plot
