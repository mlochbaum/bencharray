# Dyadic /

⟨RandBool⟩ ← •Import "../measure/gen.bqn"
scale ← •Import "../measure/scale.bqn"
types ← •Import "../params/numtype.bqn"

Bench ← {
  input‿measure ⇐ ext‿plotname ← 𝕩
  name ⇐ "replicate-"∾ext

  params ⇐ ⟨types⟩
  result ⇐ •Import "../params/ns_v.bqn"

  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    labels ⇐ (⊑params).labels
    Order ⇐ ⌽
    ChangeBounds ⇐ 0.02⊸⌈⌾(1⊸⊑) x.max⊸⌊⌾⊑
  }
}

Bench¨ ⟨
  {
    ext ⇐ "compress-length"
    plotname ⇐ "Filtering with uniform boolean list"

    input ⇐ {
      name ⇐ "Input length"
      max ⇐ 1e7
      range ⇐ scale.E23 max
    }

    Measure ⇐ { 𝕊 ⟨type⟩:
      TimeParams ⇐ { ⟨/, RandBool∘𝕩, type.GetGen𝕩⟩ }
      timeInit ⇐ 1e5‿1‿1e3
    }
  }
  {
    ext ⇐ "compress-density"
    plotname ⇐ "Filtering with length 1e5 boolean list"

    input ⇐ {
      name ⇐ "Density (+´÷≠)"
      max ⇐ 1
      log ⇐ 0 ⋄ Trans ⇐ 1.6⊸√⌾(1-˜÷)
      range ⇐ ×˜⌾(1-˜÷) ↕⊸∾⊸÷ 20
    }

    Measure ⇐ { 𝕊 ⟨type⟩:
      len ⇐ 1e5
      TimeParams ⇐ { ⟨/, len↑·/⁼(⌊0.5+𝕩×len) •rand.Subset len˙,
                         type.GetGen len⟩ }
      timeInit ⇐ 0‿0.8
    }
  }
  {
    ext ⇐ "avg"
    plotname ⇐ "Replicating to 32KB, uniform random lengths"

    input ⇐ {
      name ⇐ "Average (+´÷≠)"
      max ⇐ 200
      range ⇐ scale.E13 max
    }

    Measure ⇐ { 𝕊 ⟨type⟩:
      L←⌈((2⋆3+15)÷type.size)÷⊢ ⋄ Len⇐L⊸×
      TimeParams ⇐ { n←L𝕩 ⋄ ⟨/, n •rand.Range (1+2×𝕩)˙, type.GetGen n⟩ }
      timeInit ⇐ 2‿31
    }
  }
  {
    ext ⇐ "const"
    plotname ⇐ "Replicating by constant factor, 32KB output"

    input ⇐ {
      name ⇐ "Left argument"
      max ⇐ 200
      range ⇐ scale.E13 max
    }

    Measure ⇐ { 𝕊 ⟨type⟩:
      L←⌈((2⋆3+15)÷type.size)÷⊢ ⋄ Len⇐L⊸×
      TimeParams ⇐ { ⟨/, 𝕩˙, type.GetGen L𝕩⟩ }
      timeInit ⇐ 2‿31
    }
  }
⟩
