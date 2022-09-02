# Select function ⊏

name ⇐ "select-many"

result ⇐ •Import "../params/ns_v.bqn"

types ← •Import "../params/cputype.bqn"
params ⇐ ⟨types⟩

input ⇐ {
  name ⇐ "Right argument length"
  max ⇐ 1e6
  range ⇐ (•Import"../measure/scale.bqn").E13 max
}

Measure ⇐ { 𝕊 ⟨type⟩:
  len ⇐ 1e6
  TimeParams ⇐ {
    Ind ← (⟨𝕩⟩•Import"../measure/gen.bqn").Rand
    ⟨⊏, len Ind 𝕩˙, type.GetGen𝕩⟩
  }
}

plotOpts ⇐ {
  title ⇐ "Selecting 1e6 elements with ⊏"
  x ⇐ input
  y ⇐ result
  labels ⇐ types.labels
  Order ⇐ ⌽
}
