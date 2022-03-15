# Arithmetic functions

name ⇐ "arith"

types ← •Import "../params/cputype.bqn"
fns   ← •Import "../params/arith.bqn"
params ⇐ types‿fns

input ⇐ {
  name ⇐ "Length"
  Range ⇐ {<(2⋆3+15)÷𝕩.size}
}

result ⇐ {
  name ⇐ "Time (ns / value)"
  Calc ⇐ {𝕨𝕊x‿y: x⋈1e9×y÷x}
}

Measure ⇐ { 𝕊 type‿fn:
  ⟨float,size,max,GetGen⇐GetGenSmall⟩ ← type ⋄ size⇐
  TimeParams ⇐ {
    # Use one generator for both arguments
    float ∨ ×˙⊸≠fn ? l ← 1‿2/⟨fn, GetGen𝕩⟩ ;
    # In integer × arguments need to interact to suppress overflow: use
    # two parallel generators but run each twice so each argument sees
    # both sets of random numbers
    ⟨fn⟩ ∾ ⊣‿{(××(⌊max÷|𝕨)⌊|)𝕩} {𝕎○𝕏˜}⟜GetGen¨ <𝕩
  }
  timeInit ⇐ 1e5‿1‿1e3
}

PlotPre ⇐ {> types.num⊸⋈¨ <˘⍉1⊑⎉1𝕩}
plotOpts ⇐ {
  title ⇐ "Arithmetic with no overflow, 32KB"
  x ⇐ types
  y ⇐ result
  labels ⇐ {𝕩.Disp¨ 𝕩.range} fns
}
