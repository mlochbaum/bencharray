# Group ⊔

name ⇐ "group-density-rand"

result ⇐ •Import "../params/ns_v.bqn"

types ← •Import "../params/numtype.bqn"
params ⇐ ⟨types⟩

input ⇐ {
  name ⇐ "Left argument non-negative density"
  max ⇐ 1
  log ⇐ 0
  range ⇐ ↕⊸∾⊸÷ 10
}

Measure ⇐ { 𝕊 ⟨type⟩:
  len ⇐ 1e5
  base ← len (⟨1e3⟩•Import"../measure/gen.bqn").Rand 1e3
  TimeParams ⇐ {
    ⟨⊔, {¯1¨⌾(𝕩⊸⊏)base} (⌊0.5+len×¬𝕩) •rand.Subset len˙, type.GetGen len⟩
  }
}

plotOpts ⇐ {
  title ⇐ "1e5 elements to 1e3 groups with ⊔"
  x ⇐ input
  y ⇐ result
  labels ⇐ types.labels
  Order ⇐ ⌽
}
