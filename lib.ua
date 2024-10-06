# Experimental!
# Uiua data plotting library

~ "git: github.com/Omnikar/uiua-math" ~ FFTConvolve Gaussian

# Set struct field (should be replaced by °⊸ eventually)
S! ← ⍜^0◌:
# Force full 4 channel color
C ↚ ⬚1↙₄

# TODO: Document this more
# The following fields can take lists of
# values to map over multiple data series:
# - `PlotColor`
# - `DrawDots`
# - `DotSize`
# - `DrawLines`
# - `LineWidth`
---PlotConfig
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
    LabelSize(20) 0
    LabelColor(↯3 0.2) 0
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
    DrawDots(1) 0
    DotSize(40) 0
    DrawLines(1) 0
    LineWidth(8) 0
  }
  # Pixels per unit
  Ppu ← ÷-⊃Min⊃Max Size
---
PC ↚ PlotConfig

# Stack one RGBA image atop another
Stack ← ⍜°⍉⊂⊃(
  ↧⊸↥0÷⊃(+×¬’⊙◌|+⊃×(××¬⊙◌))
| ⍜∩¬×⊙◌
)∩⍜°⍉⍜⇌°⊂

# Image ? PlotConfig
Background ← ∧↯⊙C PC!⊃Size BgColor

# Image ? PlotConfig
Axes ← (
  -⌊÷2⟜⇡⊸PC~AxisWidth
  ×PC!⊃Min Ppu,
  ⊙(°⊟PC~Size,)°⊟⊞-
  ∩(°⊚⁅▽⊸>₀▽)⊓⤚>⊸<
  ∩⬚0↙⊙:°⊟◡⋅⋅PC~Size
  ⍉⊞×C PC~AxisColor:⇌˜⊞↥)

# Image ? PlotConfig
Gridlines ← (
  ⊸PC!⊃Min Ppu
  ⊃(×PC~GridlineInterval⋅:
  | ∩+⊙:∩⇡∩°⊟PC~Size,×)
  ∩(⌵⍜⊙+◿⤙÷2)⊙:°⊟
  ∩≤’÷2◡⋅⋅PC~GridlineWidth
  ⍉⊞×C PC~GridlineColor:⇌˜⊞↥)

# Image ? PlotConfig
AxisNums ← ⬚∘(
  PC!⊃GridlineInterval⊃Min⊃Max⊃Ppu Size°◌
  ⊓⌈⌊⤚∩÷’⊙⊓’⊙⇌
  ∩°⊟₆°⊟⍉⊟₆
  ∩⊓(
    ⤙×▽⊸≠0⍜-(⇡+1)
    ⍜×⁅˜ⁿ10⬚0⊗@.⇌°⋕ # Round values to precision of original factor
    ⍚(∧˘↘⊟⊸¯⊟.⁅÷8⟜layout) PC~NumberSize°◌⊃°⋕(×˜-)
  )∘
  ⊓⍚⍉⊙⊙⍚⇌⍚⇌
  ∩(∧◇(⬚0↥⬚0↙⁅⊟⊙:¯+⌊÷2⤚⧻)⊙⊙⊙[])
  ↥∩⇌∩⬚0↙’⇌PC~Size°◌⍉
  ⍉⊞×C PC~NumberColor°◌
)

# Convolution kernel for thickening dots and lines
# Kernel ? Size
WidthKernel ↚ °√₄↧1×2√₁₆Gaussian⤙÷40⍜(÷2+1)⁅
# Rounding dot size up to an odd number
# gives the post-convolution array the correct shape

# Returns pixel coordinates of points and whether each
# point is inside the x bounds and the y bounds
PointsToPx ↚ ∩≡⇌⊃(⍉×⊓<>’⊓⍉PC!⊃Min Max|⁅×⊙-∩¤PC!⊃Ppu Min:)

# Image ? Data PlotConfig
Dots ← (
  °⊚▽≡/×⊸PointsToPx
  ⇌⬚0↙⇌PC~Size,
  WidthKernel PC~DotSize,
  ↧1↘¯⟜↘⌊÷2△⟜FFTConvolve
  ⍉⊞×C PC~PlotColor:)

# Coordinates of pixels creating a line
# between two given pixel coordinates
# CoordList ? StartCoord EndCoord
LineCoords ↚ +×¤: ⍥≡⇌:⁅≡⊟⊙×⤙÷⟜⇡/↥⟜/↧⟜/> ⊃⌵±⊃-¤

Lines ← (
  ⊸PointsToPx

  # Handle lines connecting to out-of-bounds points by
  # projecting said points onto the bounding box
  ∩◫₂⊙⊙⊸⍥₂¤
  ▽’¬⊸≡(/×♭)
  ⍜⊙▽(
    ≡⨬(
      -1⊓PC~Size °⊟:
      ⊃(∩(˜÷∩-,)0_0◡⋅⊙∘)⋅⊙∘
      ⁅⍜⊙-×↥0/↥↧
    )⊢≡⊓≡/×(⊟⟜⇌))
  ▽≡(/×♭)∩⍉×⊓≥<0_0,⇌PC~Size◡:°⍉

  °⊚/◇⊂⍚/LineCoords
  ⇌⬚0↙⇌PC~Size,
  ↧1↘¯⟜↘⌊÷2△⟜FFTConvolve WidthKernel PC~LineWidth,
  ⍉⊞×C PC~PlotColor:
)

# Distribute specified fields of a `PlotConfig`
# ? (FieldGetter:ArgRank)+
DistrFields! ↚^ (
  ⍚$"⟜⍜⊙_(⊡◿⧻,)"⟜⍚$"⊙⍜_(☇_)"⍚°$"_:_"⊙◌
  ⊂□$"◌≡(_)⊓⇡¤"/$"_\n_")

# Infer values for a `PlotConfig` field using
# a function that operates on input data
Infer‼ ↚ ⟜(⍜^0(⍜∩▽◌’⊸=∞):^1)

# TODO: Document this more
# Plot some data with a specified `PlotConfig`
# Data can be a single shape 2_n array or a
# list of boxed shape 2_n arrays.
# Image ? Data PlotConfig
Plot ← (
  ⊙(>0⊸[∩⧻PC!⊃YLabel XLabel]⟜PC~Size⟜Background
    ⍜⊙PC~Size-×+⟜+⌊⊸÷4 PC~LabelSize,)
  ⍥¤=2⧻⊸△
  PC!Infer‼GridlineInterval(⍜×⁅˜ⁿ10¯⌊⊸ₙ10÷5-⊃/↧/↥/◇⊂)
  PC!Infer‼Min(-÷5GridlineInterval,/↧/◇⊂)
  PC!Infer‼Max(+÷5GridlineInterval,/↥/◇⊂)
  /Stack⊸⬚∘[
    ⬚◌/Stack≡(
      ⬚◌/Stack◇[
        ⋅◌⍥◠Dots PC~DrawDots,
        ⍥◠Lines PC~DrawLines,])
    ⊙PC!DistrFields!(
      PlotColor : 1
    | DotSize : 0
    | LineWidth : 0
    | DrawDots : 0
    | DrawLines : 0
    )⟜⧻ °◌
    ⟜AxisNums
    ⟜Axes⟜Gridlines
  ]
  PC!⊃LabelColor⊃LabelSize⊃XLabel YLabel:
  ⊙∩(∧˘↘⊟⊸¯⌊÷4⟜layout)⊙’
  ⊡1△:⊙(⟜⧻,)∩(⤸1⍉⊞×)’C
  ⊙˜⊂:⤸1⊙⇌∩(↻⌊÷2-⊃⊙⧻⬚0↙)
  Stack↙×1_¯1⇌:≡⊂⬚0↙⧻,
)
