# Arithmetic functions

name ⇐ "arith"

types ← •Import "../params/cputype.bqn"
fns   ← •Import "../params/arith.bqn"
params ⇐ types‿fns

Measure ⇐ { 𝕊 type‿fn:
  float‿size‿max ← type
  scale ⇐ ⟨(2⋆3+15)÷size⟩
  Result ⇐ {x𝕊y: ⊑1e9×y÷x}
  GetGen ← {
    ⟨Rand⟩ ← ⟨𝕩⟩ •Import "../measure/gen.bqn"
    (⌈(1⌈max)÷2) -˜ 𝕩 Rand max˙
  }
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

PlotPre ⇐ {> (↕4)⊸⋈¨ <˘⍉𝕩}
plotOpts ⇐ {
  title ⇐ "Arithmetic with no overflow, 32KB"
  x ⇐ types
  y ⇐ {name⇐"Time (ns / value)"}
  labels ⇐ {𝕩.Disp¨ 𝕩.range} fns
}
