# Table modifier

name ⇐ "table"

types ← •Import "../params/cputype.bqn"
fns ← ⟨⊏⟨⌈⟩⟩ •Import "../params/arith.bqn"
params ⇐ types‿fns

xmax ← 1e5
Flip ← xmax⌈∘÷⊢  # Length of other dimension
input ⇐ {
  name ⇐ "Left argument length"
  range ⇐ {(⊢∾Flip∘⌽) ⍷ ⌈ 𝕩 ⋆ (2⊸×÷˜0∾0.5+↕) ⌈2÷˜ ⌈1.3⋆⁼𝕩} xmax
}

result ⇐ {
  name ⇐ "Time (ns / value)"
  Calc ⇐ {𝕨𝕊x‿y: x⋈1e9×y÷Flip⊸×x}
}

Measure ⇐ { 𝕊 type‿fn:
  ⟨max⟩ ← type
  GetGen ← {
    ⟨Rand⟩ ← ⟨𝕩⟩ •Import "../measure/gen.bqn"
    (⌈(1⌈max)÷2) -˜ 𝕩 Rand max˙
  }
  TimeParams ⇐ { ⟨fn⌜⟩ ∾ ⋈○GetGen⟜Flip 𝕩 }
  timeInit ⇐ 1e4‿1‿1e3
}

PlotPre ⇐ ⌽
plotOpts ⇐ {
  title ⇐ "Arithmetic ⌈⌜ with 1e5-element result"
  x ⇐ input
  y ⇐ result
  labels ⇐ {𝕩.label}¨ ⌽types.range
}
