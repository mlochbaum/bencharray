# Search: two-argument ∊⊐⊒

scales ← •Import "../measure/scale.bqn"
ns     ← •Import "../params/ns_v.bqn"
types  ← •Import "../params/cputype.bqn"

# Inputs
Length ← {
  name ⇐ ∾"Searched-"‿𝕨‿" length"
  range ⇐ scales.E13 max ⇐ 𝕩
}

Bench ← {
  input‿Measure ⇐ ext‿desc ← 𝕩
  name     ⇐ "bins-"∾ext
  plotname ⇐ desc
  params ⇐ ⟨types⟩
  result ⇐ ns
  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    ⟨labels⟩ ⇐ ⊑params
  }
}

Bench {
  ext ⇐ "rand-up"
  desc ⇐ "Bins Up for 1e6 random numbers"
  input ⇐ "in" Length 1e7
  Measure ⇐ { 𝕊 ⟨type⟩:
    ⟨GetGen,GetGenSorted⟩ ← type
    len ⇐ 1e6
    TimeParams ⇐ { ⟨⍋, GetGenSorted 𝕩, (𝕩+1) GetGen len⟩ }
  }
}
