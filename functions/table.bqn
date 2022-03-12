# Table modifier

name ⇐ "table"

arith ← ⊏⟨⌈⟩

xmax ← 1e5
measure ⇐ (↕4) { type𝕊fn:
  float ← 64 = size ⇐ 2⋆3+type
  max ← (¬float) × 1-˜2⋆size-1
  Flip ← xmax⌈∘÷⊢  # Length of other dimension
  scale ⇐ {(⊢∾Flip∘⌽) ⍷ ⌈ 𝕩 ⋆ (2⊸×÷˜0∾0.5+↕) ⌈2÷˜ ⌈1.3⋆⁼𝕩} xmax
  Result ⇐ {x𝕊y: x⋈1e9×y÷Flip⊸×x}
  GetGen ← {
    ⟨Rand⟩ ← ⟨𝕩⟩ •Import "../measure/gen.bqn"
    (⌈(1⌈max)÷2) -˜ 𝕩 Rand max˙
  }
  TimeParams ⇐ { ⟨fn⌜⟩ ∾ ⋈○GetGen⟜Flip 𝕩 }
  timeInit ⇐ 1e4‿1‿1e3
  xmax ⇐ xmax
}⌜ arith

PlotPre ⇐ ⌽
plotOpts ⇐ {
  title ⇐ "Arithmetic ⌈⌜ with 1e5-element result"
  xcapt ⇐ "Left argument length"
  ycapt ⇐ "Time (ns / value)"
  labels ⇐ ⌽(∾⟜"-byte int"¨"124")∾<"8-byte float"
}
