# Reshape ⥊

scale ← •Import "../measure/scale.bqn"
types ← •Import "../params/numtype.bqn"

Bench ← {
  input‿measure ⇐ ext‿plotname ← 𝕩
  name ⇐ "reshape-"∾ext

  params ⇐ ⟨types⟩
  result ⇐ ({⟨r⇐denom⟩:⟨{denom⇐r}⟩;⟨⟩}𝕩) •Import "../params/ns_v.bqn"

  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    labels ⇐ (⊑params).labels
    Order ⇐ ⌽
    ChangeBounds ⇐ x.max⊸⌊⌾⊑
  }
}

Bench¨ ⟨
  {
    ext ⇐ "double"
    plotname ⇐ "Reshaping list to double length"

    input ⇐ {
      name ⇐ "Input length"
      max ⇐ 1e5
      range ⇐ scale.E23 max
    }

    denom ⇐ "input"
    Measure ⇐ { 𝕊 ⟨type⟩:
      TimeParams ⇐ { ⟨⥊, 2×𝕩, type.GetGen𝕩⟩ }
      timeInit ⇐ 3‿1e3‿1‿1e2
    }
  }
  {
    ext ⇐ "large"
    plotname ⇐ "Reshaping to 32KB"

    input ⇐ {
      name ⇐ "Input length"
      max ⇐ 1e3
      range ⇐ scale.E13 max
    }

    denom ⇐ "byte out"
    Measure ⇐ { 𝕊 ⟨type⟩:
      len ⇐ 2⋆15
      l ← (len×8) ÷ type.size
      TimeParams ⇐ { ⟨⥊, l, type.GetGen 𝕩⟩ }
      timeInit ⇐ 2‿180‿1‿55
    }
  }
⟩
