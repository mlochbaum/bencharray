# Table modifier

name ⇐ "table"

result ⇐ {denom⇐"output"} •Import "../params/ns_v.bqn"

types ← •Import "../params/cputype.bqn"
fns ← ⟨⊏⟨⌈⟩⟩ •Import "../params/arith.bqn"
params ⇐ types‿fns

xmax ← 1e5
Flip ← xmax⌈∘÷⊢  # Length of other dimension
scales ← •Import "../measure/scale.bqn"
input ⇐ {
  name ⇐ "Left argument length"
  range ⇐ 1.3 scales._exp2d xmax
}

Measure ⇐ { 𝕊 type‿fn:
  Len ⇐ Flip⊸×
  TimeParams ⇐ { ⟨fn⌜⟩ ∾ ⋈○type.GetGenSmall⟜Flip 𝕩 }
}

plotOpts ⇐ {
  title ⇐ "Arithmetic ⌈⌜ with 1e5-element result"
  x ⇐ input
  y ⇐ result
  key ⇐ types
}
