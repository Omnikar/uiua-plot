# Experimental!
# Uiua data plotting library

~ "git: github.com/Omnikar/uiua-math" ~ FFTConvolve Gaussian

# Apply a color to an alpha map
C ← ⍜(⊣°⍉)×∧↯⇌◡⋅△⬚1↙₄
# Round to one significant figure
AutoRound ← ⍜×⁅˜ⁿ10¯⌊⊸ₙ10

Num  ↚ °0type
Char ↚ °1type
Box  ↚ °2type

# TODO: Document this more
# The following fields can infer their values based on data:
# - `Min`
# - `Max`
# - `GridlineInterval`
# The following fields provide defaults for unspecified series-specific values:
# - `DrawDots`
# - `DotSize`
# - `DrawLines`
# - `LineWidth`
┌─╴PlotConfig
  ~ {
    Min: °2°¤△⟜Num ← ⊟.∞
    Max: °2°¤△⟜Num ← ⊟.∞
    Size: °2°¤△⟜Num ← 512_512
    BgColor: ⍣°3°4°¤△⟜Num ← ↯3 1
    AxisWidth: °[]△⟜Num ← 2
    AxisColor: ⍣°3°4°¤△⟜Num ← ↯3 0
    GridlineWidth: °[]△⟜Num ← 1
    GridlineColor: ⍣°3°4°¤△⟜Num ← ↯3 0.7
    GridlineInterval: °2°¤△⟜Num ← ⊟.∞
    NumberSize: °[]△⟜Num ← 15
    NumberColor: ⍣°3°4°¤△⟜Num ← ↯3 0.3
    XLabel: °[W]△⟜Char ← ""
    YLabel: °[W]△⟜Char ← ""
    AxisLabelSize: °[]△⟜Num ← 20
    AxisLabelColor: ⍣°3°4°¤△⟜Num ← ↯3 0.2
    PlotLabelSize: °[]△⟜Num ← 15
    PlotLabelColor: ⍣°3°4°¤△⟜Num ← ↯3 0.2
    BarWidth: °[]△⟜Num ← 40
    BarLabels: °[W]△⟜≡◇Char⟜Box ← {}
    BarLabelSize: °[]△⟜Num ← 15
    BarLabelColor: ⍣°3°4°¤△⟜Num ← ↯3 0.2
    # Series-specific global defaults
    DrawDots: °[]△⟜Num ← 1
    DotSize: °[]△⟜Num ← 40
    DrawLines: °[]△⟜Num ← 1
    LineWidth: °[]△⟜Num ← 8
  }
  # Pixels per unit
  Ppu     ← ÷-⊃Min⊃Max Size
  Bounds  ← ⌅([⊃Min Max]|⟜[⊃Min Max]|⍜Max◌⍜Min◌⊙°⊟)
  XBounds ← ⊢⍉Bounds
  YBounds ← ⊣⍉Bounds
└─╴
PC ↚ PlotConfig

┌─╴Data
  ~ {
    Values
    Color: ⍣°3°4°¤△⟜Num ← ↯4 ∞
    Label: °[W]△⟜Char ← ""
    DrawDots: °[]△⟜Num ← ∞
    DotSize: °[]△⟜Num ← ∞
    DrawLines: °[]△⟜Num ← ∞
    LineWidth: °[]△⟜Num ← ∞
  }
└─╴
# Create a `Data` instance that draws only dots
Scatter ← Data!(°⊸DrawDots 1 °⊸DrawLines 0 New)
# Create a `Data` instance that draws only lines
Line ← Data!(°⊸DrawLines 1 °⊸DrawDots 0 New)

# Stack one RGBA image atop another
Stack ← ⍜°⍉⊂ ↧⊸↥0 ⤚÷⊃(-𝄐⊃×+|+⊙×˜∩×⟜¬) ∩⍜(⇌°⍉)°⊂

# Image ? PlotConfig
Background ← ∧↯⊙⬚1↙₄ PC!⊃Size BgColor

# Image ? PlotConfig
Axes ← (
  -⌊÷2⟜⇡⊸PC~AxisWidth
  ×◡⋅PC!⊃Min Ppu
  ⊙(°⊟◡⋅PC~Size)°⊟⊞-
  ∩(°⊚⁅▽⊸≥0▽)⊓⤚>⊸<
  ∩⬚0↙⊙:°⊟◡⋅⋅PC~Size
  C PC~AxisColor :⇌˜⊞↥
)

# Image ? PlotConfig
Gridlines ← (
  ⊸PC!⊃Min Ppu
  ⊃(×PC~GridlineInterval⋅:
  | ∩+⊙:∩⇡∩°⊟◡⋅PC~Size×)
  ∩(⌵⍜⊙+◿⤙÷2)⊙:°⊟
  ∩⌞≤÷2◡⋅⋅PC~GridlineWidth
  C PC~GridlineColor :⇌˜⊞↥
)

# Image ? PlotConfig
AxisNums ← ⬚∘(
  PC!⊃GridlineInterval⊃Min⊃Max⊃Ppu Size°◌
  ⊓⌈⌊⤚∩⌞÷⊙⊓⟜:⊙⇌
  ∩°⊟₆°⊟⍉⊟₆
  ∩⊓(
    ⤙×▽⊸≠0⍜-(⇡+1)
    ⍜×⁅˜ⁿ10⬚0⊗@.⇌°⋕ # Round values to precision of original factor
    ⍚(∧⌝↘⊟⊸¯⊟.⁅÷8⟜layout) PC~NumberSize°◌⊃°⋕(×˜-)
  )∘
  ⊓⍚⍉⊙⊙⍚⇌⍚⇌
  ∩(♭₂∧◇(⬚0↥⬚0↙⁅⊟⊙:¯+⌊÷2⧻⟜:)⊙⊙⊙[])
  ↥∩⇌∩⌞⬚0↙⇌PC~Size°◌⍉
  C PC~NumberColor°◌
)

# Legend ? Data PlotConfig
Legend ← (
  ⊙⊸¤
  ≡PC!Data!⊃⋅PlotLabelSize⊃Color⊃°◇°Label⋅PlotLabelColor
  ⍚(≡⊂⊓(˜C≡⬚0↙⌊×3/2⊸⧻¬↯⟜⊚|˜C layout))⟜:
  PC~PlotLabelSize⤙⊙⊓(⊢PC~Size)⊓0[]≡◇(⧻⊢)⟜:
  ⟜⊃(⊕□˜▽°⊏⇌⊂◌∧(⨬⋅⊓-+₁⊓˜-⋅⊓1⊂: ⊙◡< ⊙+)⤙⊓:∘)⋅⋅∘
  ⟜(≡◇∧≡⬚0↙≡⊟¯⌊÷2⊸+≡◇(⧻⊢)⟜:⍚/◇≡(⊂⊂)¤⍉↯4↯⟜⊚)
  ⟜(/(⊂⊂)⍉↯4˜↯0˜⊟⊡2◡⋅△)
  ∧⌝↘⊟⊸¯⌊÷2
)

# Convolution kernels
# Rounding dot size up to an odd number gives
# the post-convolution array the correct shape

# Kernel ? Size
CircleKernel ← ⁿ4↧1×2√₁₆Gaussian⤙÷40⍜(÷2+1)⁅

# Kernel ? Size
XKernel ← (
  0.3:¤↥⊸⇌⊞=.⊸⇡⍜(÷2+1)⁅×0.3
  /↥≡↻♭₂⊞⊟.-÷2-1⟜⇡⍜(÷2+1)⌊×
)

# Kernel ? Size
BoxKernel ← ¬↯⟜⊚⍜(÷2+1)⁅×0.3

# Non-rounded non-bound-checked pixel coordinates of points
# Coords ? Points PlotConfig
PointsToPx ← ≡⇌×⊙-∩¤PC!⊃Ppu Min :

# Image ? Data PlotConfig
Dots ← (
  ⤚⤙(⁅PointsToPx Data~Values)
  ⇌⬚0↙:°⊚ ▽⊸∊♭₂⇡⟜:⇌PC~Size
  CircleKernel◡⋅Data~DotSize
  ↘¯⟜↘⌊÷2△⟜FFTConvolve
  ↧1C Data~Color :
)

# Image ? Data PlotConfig
Lines ← (
  ⤚⤙(⧈∘2≡/ℂPointsToPx Data~Values)
  ¤/ℂ°⍉⇡⇌PC~Size
  ⇌/↧≡/(⌵-×↥0↧1÷∩(/+×∩⊟∩°ℂ)⤙⤙◠:∩⌞-)
  ¬↥0↧1-÷10◡⋅Data~LineWidth×0.7
  C Data~Color :
)

# Plot a single series
# Image ? Data PlotConfig
SingleSeries ← /Stack/◇⊂Data!↓{
  ⤙₂⨬[][Lines]⊸DrawLines
  ⨬[][Dots]⊸DrawDots
}

# Bars ? Data PlotConfig
SingleBars ← (
  PC~YBounds⟜:˜⊙⊸Data~Values
  ⟜⊃(↥⊙↧°⊟)⊢
  ↥⊃(↥0-↥0⊢|⌵↧0-↧0⊣|¯↧0-↧0◌)
  ∩× ⊸:⊙(⊣◡⋅PC~Ppu)
  ⬚0≡⌝↘⁅:⬚0≡↯⊙1⁅≡⊟⊙PC~BarWidth⊙⊸:
  ◡⋅PC!⊃BarWidth Size
  ⁅+÷2-⊙(⊸⊡1×÷⟜⇡◡⋅⧻⊢)
  ⇌⬚0↙⇌PC~Size :/↥⬚0≡≡⌝↘
  C Data~Color :
)

Bars ← (
  ⍜⬚0≡Data~Values∘
  ≡SingleBars⊙⊸¤
  PC~BarWidth :
  ⁅×⇌-÷2-1⟜⇡◡⋅⧻
  /Stack≡≡↻
)

# Generate a `Data` instance that plots a given function
# Data ? XBounds
Func! ← (
  /-⟜:⊙PC!(Size New)
  ≡⊟⟜≡₀^0˜⊂⊣⤙⍜×/⍜-(⇡⁅)÷5÷⊙⊢
  Data!(°⊸DrawDots0New)
)

Red    ← ÷255 199_68_64
Blue   ← ÷255 45_112_179
Green  ← ÷255 56_140_70
Purple ← ÷255 96_66_166
Orange ← ÷255 250_126_25

# Colors from Desmos graphing calculator
# https://www.desmos.com/api/v1.7/docs/index.html#document-colors
DefaultColors ← ≡⊂[
  Red
  Blue
  Green
  Purple
  Orange
  Black
]1

# Infer values for a config field using
# a function that operates on input data
# ? FieldGetter InferenceFunction
Infer‼ ← ⟜(⍜(∩♭^0|⍜∩▽◌⟜:⊸=∞):^1)
# Inherit defaults from a PlotConfig to
# the DataConfigs of some data
# ? DataConfigGetter PlotConfigGetter
Inherit‼ ← ⍜:Infer‼≡^0(≡⊙∘^1)

ColorAutoInfer ← (
  ≡⍜Data~Color⬚∞↙₄
  ⍜:Infer‼≡Data~Color⋅(⊏◿◡⋅⧻ ⇡◡⋅⧻ DefaultColors)
)

PreChart ← (
  ⊙⟜Background
  ⟜(±⊸⧻▽>0⊸≡(⧻Data~Label)
    ⨬⋅⟜(°△[0⊙4]⊢PC~Size)(⤚(⍜⊙(⊣PC~Size)-⧻)⊸Legend))
  ⊙(>0⊸[∩⧻PC!⊃YLabel XLabel]⟜PC~Size
    ⍜⊙PC~Size-×+⟜+⌊⊸÷4 ◡⋅PC~AxisLabelSize)
)

PostChart ← (
  PC!⊃AxisLabelColor⊃AxisLabelSize⊃XLabel YLabel :
  ⊙∩⌞(∧⌝↘⊟⊸¯⌊÷4⟜layout)
  ⊡1△:⊙◡⋅⟜⧻∩⌞(⤸1⍉⊞×)⬚1↙₄
  ⊙˜⊂:⤸1⊙⇌∩(↻⌊÷2-⊃⊙⧻⬚0↙)
  Stack˜⊂↙×1_¯1⇌:≡⊂⬚0↙◡⋅⧻
)

# TODO: Document this more
# Create a line/scatter plot with a list of `Data`
# Each `Data~Values` should be a list of 2D coordinates withid
# stored as a single rank 2 array.
# Use `⬚ fill` to provide a custom `PlotConfig`.
# Image ? Data
Plot ← (
  ColorAutoInfer ⊙⍣°◌PC ♭₂

  PC!Infer‼GridlineInterval(AutoRound÷5-⊃/↧/↥/◇⊂⍚Data~Values)
  PC!Infer‼Min(-÷5◡⋅GridlineInterval/↧/◇⊂⍚Data~Values)
  PC!Infer‼Max(+÷5◡⋅GridlineInterval/↥/◇⊂⍚Data~Values)
  Inherit‼Data~DrawDots PC~DrawDots
  Inherit‼Data~DotSize PC~DotSize
  Inherit‼Data~DrawLines PC~DrawLines
  Inherit‼Data~LineWidth PC~LineWidth

  PreChart
  /Stack⊸[
    /Stack⇌≡SingleSeries⊙¤
    ⊙⟜(AxisNums|Axes|Gridlines)
  ]
  PostChart
)

# TODO: Document this more
# Create a bar chart with a list of `Data`
# Each `Data~Values` should be a list of bar heights.
# Use `⬚ fill` to provide a custom `PlotConfig`.
# Image ? Data
BarChart ← (
  ⊙⍜PC~XBounds⋅1_1 ♭₂ ⊙⍣°◌PC
  PC!Infer‼YBounds(⊟⊓⌞↧↥0∩(+⊸÷20)⊃/↧/↥♭⬚0≡Data~Values)
  PC!Infer‼(⊣GridlineInterval|AutoRound÷5/-⋅⊸YBounds)
  ColorAutoInfer
  ⊙⍜(⊢PC~GridlineInterval)⋅∞

  PreChart

  ◠(⬚""↙⊙⊸PC~BarLabels/↥≡(⧻Data~Values)
    ⍚⌝↘⁅÷8⟜⍚layout◡⋅PC~BarLabelSize
    ×÷⟜⇡◡⋅⧻ ⊢◡⋅PC~Size
    # ⁅+÷2-⊙⊸⊡₁◡⋅≡◇(⧻⊢)
    ⁅+÷2-⊙⊸⊡₁◡⋅≡◇⧻₁
    ≡⬚0↙⊢◡⋅PC~Size/↥⬚0≡◇≡⌝↘
    C PC~BarLabelColor :)
  ⊙(⍜⊙(⊣PC~Size)-◡⋅⧻)

  ⊂⊙:/Stack ⊸[⊙::Bars⊙⟜(AxisNums|Axes|Gridlines)]

  PostChart
)

# TODO: Document this more
# Create a histogram with a single set of `Data`
# `Data~Values` should be a list of numbers.
# Use `⬚ fill` to provide a custom `PlotConfig`.
# Histogram bucket intervals can be specified
# through the x component of `GridlineInterval`
# in the `PlotConfig`.
# Image ? Data
Histogram ← (
  ⊙⍣°◌PC
  PC!Infer‼(⊢GridlineInterval|AutoRound÷10-⊃/↧/↥Data~Values)
  PC!Infer‼XBounds(⍜÷⁅⊢◡⋅GridlineInterval⊟⊃/↧/↥Data~Values)
  ⍜♭₂ColorAutoInfer
  ⍜Data~Values(
    ⊢◡⋅PC!⊃GridlineInterval XBounds
    °⊂⍜÷(⍜-(⇡⁅+1)°⊟)
    ⬚0↙⧻:°⊚⊗1⊸⊞≥▽⊸≥⊙:
  )

  ⍜¤PreChart

  ⊙°⊸PC~BarWidth :⌈⊢×◡⋅PC!⊃Ppu GridlineInterval
  PC!Infer‼YBounds(⊟0⁅×1.04/↥Data~Values)
  PC!Infer‼(⊣GridlineInterval|AutoRound÷5/-⋅⊸YBounds)
  /Stack⊸[⊙::SingleBars⊙⟜(AxisNums|Axes|Gridlines)]

  PostChart
)

OptArg‼ ←^ $"_! ← ⬚_!(^0 New)_"⟜:°□₂⊙◌
OptArg‼Plot PlotConfig
OptArg‼BarChart PlotConfig
OptArg‼Histogram PlotConfig
