# Search: two-argument ∊⊐⊒

scales ← •Import "../measure/scale.bqn"
ns     ← •Import "../params/ns_v.bqn"
types  ← •Import "../params/cputype.bqn"

# Inputs
Length ← {
  name ⇐ ∾"Searched-"‿𝕨‿" length"
  range ⇐ scales.E13 max ⇐ 𝕩
}

sizes ← {
  name ⇐ "Size"
  range ⇐ 10‿25‿100‿1e6
  labels ⇐ ("in "∾•Repr)¨ range
  Order ⇐ ⌽
}

Bench ← {
  params‿input‿Measure ⇐ ext‿desc ← 𝕩
  name     ⇐ "bins-"∾ext
  plotname ⇐ desc
  result ⇐ ns
  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    key ⇐ ⊑params
  }
}

summary ← {
  ext ⇐ "rand-up"
  desc ⇐ "Bins Up for 1e6 random numbers"
  params ⇐ ⟨types⟩
  input ⇐ "in" Length 1e7
  Measure ⇐ { 𝕊 ⟨type⟩:
    ⟨GetGen,GetGenSorted⟩ ← type
    len ⇐ 1e6
    TimeParams ⇐ { ⟨⍋, GetGenSorted 𝕩, (𝕩+1) GetGen len⟩ }
  }
}

BenchType ← {
  ext ⇐ 𝕩.disp∾"-up"
  desc ⇐ ∾"Bins Up on random "‿𝕩.label‿"s"
  params ⇐ ⟨sizes⟩
  input ⇐ "for" Length 1e5
  ⟨GetGen,GetGenSorted⟩ ← 𝕩
  Measure ⇐ { 𝕊 ⟨len⟩:
    TimeParams ⇐ { ⟨⍋, GetGenSorted len, (𝕩+1) GetGen 𝕩⟩ }
  }
}

Bench¨ ⟨summary⟩∾BenchType¨ types.range
