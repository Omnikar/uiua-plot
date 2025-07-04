# Experimental!

# Import functions from plotting library
~ "../lib" ~ Data Plot!

# Binomial probability mass function
# ? n p k
Binom ← ××ⁿ-⊃⊃⤙⊙⊓¬◌⋅˜ⁿ𝄐˜⧅<

# Generate binomial PMF data
20 0.25_0.5_0.75 ⇡21
⍉˜⊟∩°¤⊞⊸Binom

[Blue Red Green]

{"n=20,p=0.25"
 "n=20,p=0.5"
 "n=20,p=0.75"}

≡◇Data!(°⊸⊃Label Color ⊙⊙New)

Plot!(
  °⊸(⊢XBounds) ¯2
  °⊸GridlineInterval 5_0.05
  °⊸Size 600_450
  ⍜DotSize(×0.6)
  ⍜LineWidth(×0.2)
  °⊸XLabel "k"
  °⊸YLabel "P(X=k)"
)

&ims
