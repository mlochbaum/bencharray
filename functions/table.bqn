# Table modifier

name ⇐ "table"

result ⇐ {denom⇐"output"} •Import "../params/ns_v.bqn"

types ← •Import "../params/cputype.bqn"
fns ← ⟨⊏⟨⌈⟩⟩ •Import "../params/arith.bqn"
params ⇐ types‿fns

xmax ← 1e5
Flip ← xmax⌈∘÷⊢  # Length of other dimension
input ⇐ {
  name ⇐ "Left argument length"
  range ⇐ {(⊢∾Flip∘⌽) ⍷ ⌈ 𝕩 ⋆ (2⊸×÷˜0∾0.5+↕) ⌈2÷˜ ⌈1.3⋆⁼𝕩} xmax
}

Measure ⇐ { 𝕊 type‿fn:
  Len ⇐ Flip⊸×
  TimeParams ⇐ { ⟨fn⌜⟩ ∾ ⋈○type.GetGenSmall⟜Flip 𝕩 }
}

plotOpts ⇐ {
  title ⇐ "Arithmetic ⌈⌜ with 1e5-element result"
  x ⇐ input
  y ⇐ result
  labels ⇐ types.labels
  Order ⇐ ⌽
}
