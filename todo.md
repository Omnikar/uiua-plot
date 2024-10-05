## Features
- Inference of some `PlotConfig` values, such as plot bounds
- Axis labels
- Legend?
- Config option for whether to display axis numbers
- Support for minor gridlines by passing higher rank arrays to `GridlineInterval`, `GridlineWidth`, and `GridlineColor`

## Bugs
- When drawing lines, out-of-bounds points are taken completely out of consideration, and visible points that should connect to them connect to each other instead.
- Error if a data series is entirely out of bounds of the plot
- Floating point imprecision causes some axis numbers to be thrown off. [Example](https://www.uiua.org/pad?src=0_13_0-dev_2__IyBFeHBlcmltZW50YWwhCn4gImdpdDogZ2l0aHViLmNvbS9PbW5pa2FyL3VpdWEtcGxvdCIgfiBQbG90IFBsb3RDb25maWcgUyEKIyA_IG4gcCBrCkJpbm9tIOKGkCDDl8OX4oG_LeKKg-KKg-KkmeKKmeKKk8Ks4peM4ouFy5zigb8oy5zip4U84oqZ4peMKQoKUGxvdENvbmZpZyEoCiAgTmV3CiAgUyFNaW4gwq8xLjVfwq8wLjAxCiAgUyFNYXggMjFfMC4yMgogIFMhR3JpZGxpbmVJbnRlcnZhbCA1XzAuMDUKICBTIVNpemUgNjAwXzQ1MAogIFMhUGxvdENvbG9yIFswXzFfMCAxXzBfMCAwXzBfMV0KICDijZxEb3RTaXplKMOXMC42KQogIOKNnExpbmVXaWR0aCjDlzAuNykKKQoKMjAgMC43NV8wLjVfMC4yNSDih6EyMQrijYnLnOKKn-KIqcKwwqTiip7iirhCaW5vbQoKUGxvdAo=)
