# Experimental!
# Uiua data plotting library

~ "git: github.com/Omnikar/uiua-math" ~ FFTConvolve Gaussian

# Apply a color to an alpha map
C ↚ ⍜(⊣°⍉)×∧↯⇌△,⬚1↙₄
# Round to one significant figure
AutoRound ↚ ⍜×⁅˜ⁿ10¯⌊⊸ₙ10

# TODO: Document this more
# The following fields can infer their values based on data:
# - `Min`
# - `Max`
# - `GridlineInterval`
# The following fields can take lists of
# values to map over multiple data series:
# - `PlotColor`
# - `PlotLabel`
# - `PlotLabelColor`
# - `DrawDots`
# - `DotSize`
# - `DrawLines`
# - `LineWidth`
┌─╴PlotConfig
  # New `PlotConfig` with default values
  struct{
    Min(⊟.∞) 0
    Max(⊟.∞) 0
    Size(512_512) 0
    BgColor(↯3 1) 0
    AxisWidth(3) 0
    AxisColor(↯3 0) 0
    GridlineWidth(1) 0
    GridlineColor(↯3 0.7) 0
    GridlineInterval(⊟.∞) 0
    NumberSize(15) 0
    NumberColor(↯3 0.3) 0
    XLabel("") 2
    YLabel("") 2
    AxisLabelSize(20) 0
    AxisLabelColor(↯3 0.2) 0
    PlotColor(
      # Colors from Desmos graphing calculator
      # https://www.desmos.com/api/v1.7/docs/index.html#document-colors
      ÷255[
        199_68_64
        45_112_179
        56_140_70
        96_66_166
        250_126_25
        0_0_0
      ]
    ) 0
    PlotLabel(□"") 3
    PlotLabelSize(15) 0
    PlotLabelColor(↯3 0.2) 0
    DrawDots(1) 0
    DotSize(40) 0
    DrawLines(1) 0
    LineWidth(8) 0
    BarWidth(40) 0
    BarLabel(□"") 3
    BarLabelSize(15) 0
    BarLabelColor(↯3 0.2) 0
  }
  # Pixels per unit
  Ppu     ← ÷-⊃Min⊃Max Size
  Bounds  ← ⌅([⊃Min Max]|⟜[⊃Min Max]|⍜Max◌⍜Min◌⊙°⊟)
  XBounds ← ⊢⍉Bounds
  YBounds ← ⊣⍉Bounds
└─╴
PC ↚ PlotConfig

# Stack one RGBA image atop another
Stack ← ⍜°⍉⊂⊃(
  ↧⊸↥0÷⊃(+×¬’⊙◌|+⊃×(××¬⊙◌))
| ⍜∩¬×⊙◌
)∩⍜°⍉⍜⇌°⊂

# Image ? PlotConfig
Background ← ∧↯⊙⬚1↙₄ PC!⊃Size BgColor

# Image ? PlotConfig
Axes ← (
  -⌊÷2⟜⇡⊸PC~AxisWidth
  ×PC!⊃Min Ppu,
  ⊙(°⊟PC~Size,)°⊟⊞-
  ∩(°⊚⁅▽⊸≥0▽)⊓⤚>⊸<
  ∩⬚0↙⊙:°⊟◡⋅⋅PC~Size
  C PC~AxisColor:⇌˜⊞↥)

# Image ? PlotConfig
Gridlines ← (
  ⊸PC!⊃Min Ppu
  ⊃(×PC~GridlineInterval⋅:
  | ∩+⊙:∩⇡∩°⊟PC~Size,×)
  ∩(⌵⍜⊙+◿⤙÷2)⊙:°⊟
  ∩≤’÷2◡⋅⋅PC~GridlineWidth
  C PC~GridlineColor:⇌˜⊞↥)

# Image ? PlotConfig
AxisNums ← ⬚∘(
  PC!⊃GridlineInterval⊃Min⊃Max⊃Ppu Size°◌
  ⊓⌈⌊⤚∩÷’⊙⊓’⊙⇌
  ∩°⊟₆°⊟⍉⊟₆
  ∩⊓(
    ⤙×▽⊸≠0⍜-(⇡+1)
    ⍜×⁅˜ⁿ10⬚0⊗@.⇌°⋕ # Round values to precision of original factor
    ⍚(∧⌝↘⊟⊸¯⊟.⁅÷8⟜layout) PC~NumberSize°◌⊃°⋕(×˜-)
  )∘
  ⊓⍚⍉⊙⊙⍚⇌⍚⇌
  ∩(☇1∧◇(⬚0↥⬚0↙⁅⊟⊙:¯+⌊÷2⤚⧻)⊙⊙⊙[])
  ↥∩⇌∩⬚0↙’⇌PC~Size°◌⍉
  C PC~NumberColor°◌)

# Convolution kernel for thickening dots and lines
# Kernel ? Size
WidthKernel ↚ °√₄↧1×2√₁₆Gaussian⤙÷40⍜(÷2+1)⁅
# Rounding dot size up to an odd number
# gives the post-convolution array the correct shape

XKernel ↚ (
  0.3:¤↥⊸⇌⊞=.⊸⇡⍜(÷2+1)⁅×0.3
  /↥≡↻☇1⊞⊟.-÷2-1⟜⇡⍜(÷2+1)⌊×)

# Returns pixel coordinates of points and whether each
# point is inside the x bounds and the y bounds
PointsToPx ↚ ∩≡⇌⊃(⍉×⊓<>’⊓⍉PC!⊃Min Max|⁅×⊙-∩¤PC!⊃Ppu Min:)

# Image ? Data PlotConfig
Dots ← (
  °⊚▽≡/×⊸PointsToPx
  ⇌⬚0↙⇌PC~Size,
  WidthKernel PC~DotSize,
  ↘¯⟜↘⌊÷2△⟜FFTConvolve
  ↧1C PC~PlotColor:)

# Image ? Data PlotConfig
Lines ← (
  ◫2◌⊸PointsToPx
  °⍉⇡⇌PC~Size,
  ⇌/↧≡/(⌵-×↥0↧1÷∩(/+×∩[°ℂ]).⊃,:∩-,∩₃°[°ℂ]:)¤
  ¬↥0↧1-÷10PC~LineWidth,×0.7
  C PC~PlotColor:)

# Plot a single series
# Image ? Data PlotConfig
SingleSeries ← /Stack◇[
  ⋅◌⍥◠Dots PC~DrawDots,
  ⍥◠Lines PC~DrawLines,]

# Distribute specified fields of a `PlotConfig`
# ? Default (FieldGetter:ArgRank:PickFunction)+
DistrFields! ↚^ (
  °⊂⊙◌
  ⊙(⍚°$"_:_:_"
    ⊙:⟜⍚$"⊙⍜(_|☇_)")
  # ⍚$"⟜⍜⊙(_)(⬚(_ _|_))".:
  ⍚$"⟜⍜⊙(_)(⍣(_|_ _))"⤚⋅’
  ⊂□$"◌≡(_)⊓⇡¤"/$"_\n_")

# Distribute appropriate fields of a `PlotConfig` over N rows
# NewPlotConfigs ? N PlotConfig
AutoDistrFields ← PC!DistrFields!(
  New
| PlotColor : 1 : ⊡◿⧻,
| PlotLabel : 0 : ⊡
| PlotLabelColor : 1 : ⊡↧-1⧻,
| DotSize : 0 : ⊡↧-1⧻,
| LineWidth : 0 : ⊡↧-1⧻,
| DrawDots : 0 : ⊡↧-1⧻,
| DrawLines : 0 : ⊡↧-1⧻,
| BarWidth : 0 : ⊡↧-1⧻,
)

# Infer values for a `PlotConfig` field using
# a function that operates on input data
# ? FieldGetter InferenceFunction
Infer‼ ↚ ⟜(⍜^0(⍜∩▽◌’⊸=∞∩♭):^1)

# Automatically infer `PlotConfig` fields based on data
# Data NewPlotConfig ? Data PlotConfig
AutoInfer ← (
  PC!Infer‼GridlineInterval(AutoRound÷5-⊃/↧/↥/◇⊂)
  PC!Infer‼Min(-÷5GridlineInterval,/↧/◇⊂)
  PC!Infer‼Max(+÷5GridlineInterval,/↥/◇⊂))

# Legend ? NumSeries PlotConfig
Legend ← (
  ⊸AutoDistrFields
  ≡PC!⊃PlotLabelSize⊃PlotColor⊃PlotLabel PlotLabelColor
  ⍚(≡⊂⊓(C:≡⬚0↙⌊×3/2⊸⧻¬↯⟜⊚|C:layout))’
  PC~PlotLabelSize⤙⊙⊓(⊢PC~Size)⊓0[]⤚≡◇(⧻⊢)
  ⟜⊃(⊕□˜▽°⊏⇌⊂◌∧(⨬⋅⊓-+₁⊓˜-⋅⊓1⊂: ⊙◡< ⊙+)⤙⊓:∘)⋅⋅∘
  ⟜(≡◇∧≡⬚0↙≡⊟¯⌊÷2⊸+≡◇(⧻⊢)’⍚/◇≡(⊂⊂)¤⍉↯4↯⟜⊚)
  ⟜(/(⊂⊂)⍉↯4˜↯0˜⊟⊡2△,)
  ∧⌝↘⊟⊸¯⌊÷2)

SingleBars ← (
  ⟜⊃(↥⊙↧°⊟)⊢PC~YBounds,
  ↥⊃(↥0-↥0⊢|⌵↧0-↧0⊣|¯↧0-↧0◌)
  ∩×,⊙(⊣PC~Ppu,)
  ⬚0≡⌝↘⁅:⬚0≡↯⊙1⁅≡⊟⊙PC~BarWidth⊙,
  PC!⊃BarWidth Size,
  ⁅+÷2-⊙(⊸⊡1×÷⟜⇡⧻,⊢)
  ⇌⬚0↙⇌PC~Size,/↥⬚0≡≡⌝↘
  C PC~PlotColor:)

Bars ← (
  ⊙⊸AutoDistrFields⟜⧻
  ≡SingleBars
  PC~BarWidth:
  ⁅×⇌-÷2-1⟜⇡⧻,
  /Stack≡≡↻)

PreChart ← (
  ⊙⟜Background
  ×◡⊓(=1⧻|◇≍""⊢PC~PlotLabel)
  ⨬⟜(⤚(⍜⊙(⊣PC~Size)-⧻)⊸($Legend Legend)⧻)⊙⟜(°△[0⊙4]⊢PC~Size)
  ⊙(>0⊸[∩⧻PC!⊃YLabel XLabel]⟜PC~Size
    ⍜⊙PC~Size-×+⟜+⌊⊸÷4 PC~AxisLabelSize,))

PostChart ← (
  PC!⊃AxisLabelColor⊃AxisLabelSize⊃XLabel YLabel:
  ⊙∩(∧⌝↘⊟⊸¯⌊÷4⟜layout)⊙’
  ⊡1△:⊙(⟜⧻,)∩(⤸1⍉⊞×)’⬚1↙₄
  ⊙˜⊂:⤸1⊙⇌∩(↻⌊÷2-⊃⊙⧻⬚0↙)
  Stack˜⊂↙×1_¯1⇌:≡⊂⬚0↙⧻,)

# TODO: Document this more
# Plot some data with a specified `PlotConfig`
# Data can be a single shape N_2 array or a
# list of boxed shape N_2 arrays.
# Image ? Data PlotConfig
Plot ← (
  ⍥¤=2⧻⊸△ # Fix if single rank 2 array
  AutoInfer
  PreChart
  /Stack⊸[
    /Stack⇌≡SingleSeries
    ⊙AutoDistrFields⟜⧻
    ⊙⟜(AxisNums|Axes|Gridlines)]
  PostChart)

# Create a bar chart with some data and a specified `PlotConfig`
# Data should be a rank 2 array where rows are data series
# and columns are bar groups, or a rank 1 array representing a
# single series.
# Image ? Data PlotConfig
BarChart ← (
  ⊙⍜PC~XBounds⋅1_1 ☇1
  PC!Infer‼YBounds(⊟⊓↧↥’0∩(+⊸÷20)⊃/↧/↥♭)
  PC!Infer‼(⊣GridlineInterval|AutoRound÷5/-⋅⊸YBounds)
  ⊙⍜(⊢PC~GridlineInterval)⋅∞

  PreChart

  ◠(⬚""↙⊙⊸PC~BarLabel⧻⊢
    ⍚⌝↘⁅÷8⟜⍚layoutPC~BarLabelSize,
    ×÷⟜⇡⧻,⊢PC~Size,
    ⁅+÷2-⊙⊸⊡₁≡◇(⧻⊢),
    ≡⬚0↙⊢PC~Size,/↥⬚0≡◇≡⌝↘
    C PC~BarLabelColor:)
  ⊙(⍜⊙(⊣PC~Size)-⧻,)

  ⊂⊙:/Stack⊸[⊙::Bars⊙⟜(AxisNums|Axes|Gridlines)]

  PostChart)

# Create a histogram with some data and a specified `PlotConfig`
# Does not support multiple data series. Data is expected as a
# single rank 1 list of numbers. Histogram bucket intervals can
# be specified through the x component of `GridlineInterval` in
# the `PlotConfig`.
# Image ? Data PlotConfig
Histogram ← (
  PC!Infer‼XBounds(⊟⊃/↧/↥)
  PC!Infer‼(⊢GridlineInterval|AutoRound÷10/-⋅⊸XBounds)
  ⊢PC!⊃GridlineInterval XBounds,
  °⊂⍜÷(⍜-(⇡⁅+1)°⊟)
  ⬚0↙⧻:°⊚⊗1⊸⊞≥▽⊸≥⊙:
  ⊙⍜PC~PlotColor(⊢☇1)

  ⍜¤PreChart

  ⊙°⊸PC~BarWidth:⌈÷⧻,⊢PC~Size,
  PC!Infer‼YBounds(⊟0⁅×1.04/↥)
  PC!Infer‼(⊣GridlineInterval|AutoRound÷5/-⋅⊸YBounds)
  /Stack⊸[⊙::SingleBars⊙⟜(AxisNums|Axes|Gridlines)]

  PostChart)
