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
  Num  ↚ °0type
  Char ↚ °1type
  Box  ↚ °2type
  ~{
    Min: °2°¤△⟜Num ← ⊟.∞
    Max: °2°¤△⟜Num ← ⊟.∞
    Size: °2°¤△⟜Num ← 512_512
    BgColor: ⍣°3°4°¤△⟜Num ← ↯3 1
    AxisWidth: °[]△⟜Num ← 3
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
    # Colors from Desmos graphing calculator
    # https://www.desmos.com/api/v1.7/docs/index.html#document-colors
    PlotColor: ⊃(⍣°1°2⧻|⍣°3°4⊣)△⟜Num ← ÷255[
      199_68_64
      45_112_179
      56_140_70
      96_66_166
      250_126_25
      0_0_0
    ]
    PlotLabel: ⍣°[]°[W]△⟜∵◇Char⟜Box ← □""
    PlotLabelSize: °[]△⟜Num ← 15
    PlotLabelColor: ⊃(⍣°1°2⧻|⍣°3°4⊣)△⟜Num ← ↯3 0.2
    DrawDots: ⍣°[]°[W]△⟜Num ← 1
    DotSize: ⍣°[]°[W]△⟜Num ← 40
    DrawLines: ⍣°[]°[W]△⟜Num ← 1
    LineWidth: ⍣°[]°[W]△⟜Num ← 8
    BarWidth: ⍣°[]°[W]△⟜Num ← 40
    BarLabel: ⍣°[]°[W]△⟜∵◇Char⟜Box ← □""
    BarLabelSize: °[]△⟜Num ← 15
    BarLabelColor: ⍣°3°4°¤△⟜Num ← ↯3 0.2
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

# Convolution kernels
# Rounding dot size up to an odd number gives
# the post-convolution array the correct shape

# Kernel ? Size
CircleKernel ↚ ⁿ4↧1×2√₁₆Gaussian⤙÷40⍜(÷2+1)⁅

# Kernel ? Size
XKernel ↚ (
  0.3:¤↥⊸⇌⊞=.⊸⇡⍜(÷2+1)⁅×0.3
  /↥≡↻☇1⊞⊟.-÷2-1⟜⇡⍜(÷2+1)⌊×)

# Kernel ? Size
BoxKernel ↚ ¬↯⟜⊚⍜(÷2+1)⁅×0.3

# Returns non-rounded pixel coordinates of points and whether
# each point is inside the x bounds and the y bounds
PointsToPx ↚ ∩≡⇌⊃(⍉×⊓<>’⊓⍉PC!⊃Min Max|×⊙-∩¤PC!⊃Ppu Min:)

# Image ? Data PlotConfig
Dots ← (
  °⊚⁅▽≡/×⊸PointsToPx
  ⇌⬚0↙⇌PC~Size,
  CircleKernel PC~DotSize,
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
  PC!Infer‼(⊢GridlineInterval|AutoRound÷10-⊃/↧/↥)
  PC!Infer‼XBounds(⍜÷⁅⊢GridlineInterval,⊟⊃/↧/↥)
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
