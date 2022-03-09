# Arithmetic functions

name ⇐ "arith"

arith ← ×‿+‿-‿⌊‿⌈

xmax ← 2e6
measure ⇐ (↕4) { type𝕊fn:
  float ← 64 = size ⇐ 2⋆3+type
  max ← (¬float) × 1-˜2⋆size-1
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
  xmax ⇐ xmax
}⌜ arith

PlotPre ⇐ {> (↕4)⊸⋈¨ <˘⍉𝕩}
plotOpts ⇐ {
  title ⇐ "Arithmetic with no overflow, 32KB"
  xcapt ⇐ "Type" ⋄ xlog⇐0
  ycapt ⇐ "Time (ns / value)"
  labels ⇐ •Repr¨ arith
  ChangeBounds ⇐ xmax‿10⊸⌊
}
