# Group ⊔

ns    ← •Import "../params/ns_v.bqn"
types ← •Import "../params/numtype.bqn"
scale ← •Import"../measure/scale.bqn"

Bench ← {
  input‿measure ⇐ ext‿plotname ← 𝕩
  name ⇐ "group-"∾ext

  result ⇐ ns
  params ⇐ ⟨types⟩

  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    labels ⇐ types.labels
    Order ⇐ ⌽
  }
}

Bench¨ ⟨
  {
    ext ⇐ "density-rand"
    plotname ⇐ "1e5 elements to 1e3 groups with ⊔"
    input ⇐ {
      name ⇐ "Left argument non-negative density"
      max ⇐ 1
      log ⇐ 0 ⋄ Trans ⇐ 1.6⊸√
      range ⇐ ×˜ ↕⊸∾⊸÷ 10
    }
    Measure ⇐ { 𝕊 ⟨type⟩:
      len ⇐ 1e5
      base ← len (⟨1e3⟩•Import"../measure/gen.bqn").Rand 1e3
      TimeParams ⇐ {
        ⟨⊔, {¯1¨⌾(𝕩⊸⊏)base} (⌊0.5+len×¬𝕩) •rand.Subset len˙, type.GetGen len⟩
      }
    }
  }
  {
    ext ⇐ "range-sort"
    plotname ⇐ "Partitioning 1e5 elements with ⊔"
    input ⇐ {
      name ⇐ "Number of groups"
      max ⇐ 1e6
      range ⇐ scale.E23 max
    }
    Measure ⇐ { 𝕊 ⟨type⟩:
      len ⇐ 1e5
      TimeParams ⇐ {
        Grp ← ∧ len (⟨𝕩⟩•Import"../measure/gen.bqn").Rand 𝕩˙
        ⟨⊔, Grp, type.GetGen len⟩
      }
    }
  }
⟩
