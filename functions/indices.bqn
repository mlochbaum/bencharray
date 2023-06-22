# Monadic /

⟨RandBool⟩ ← •Import "../measure/gen.bqn"
scale ← •Import"../measure/scale.bqn"

sizes ← {
  name ⇐ "Size"
  range ⇐ 10⋆exp←2‿4‿6
  labels ⇐ ("length 1e"∾•Repr)¨ exp
}

Bench ← {
  params‿input‿measure ⇐ ext‿plotname ← opts ← 𝕩
  name ⇐ "indices-"∾ext

  result ⇐ ({⟨r⇐output⟩:⟨r⟩;⟨⟩}𝕩) •Import "../params/ns_v.bqn"
  result.SetMin 0.01

  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    key ⇐ {labels⇐⋈"/"} ⊣´ params
  }
}

Bench¨ ⟨
  {
    ext ⇐ "where-length"
    plotname ⇐ "Indices from uniform boolean list"
    params ⇐ ⟨⟩

    input ⇐ {
      name ⇐ "Input length"
      max ⇐ 1e7
      range ⇐ scale.E13 max
    }
    output ⇐ {denom ⇐ "input"}

    measure ⇐ {
      TimeParams ⇐ { ⟨/, RandBool∘𝕩⟩ }
      timeInit ⇐ 1e5‿1‿1e3
    }
  }
  {
    ext ⇐ "where-density"
    plotname ⇐ "Indices from boolean lists"

    params ⇐ ⟨sizes⟩
    input ⇐ {
      name ⇐ "Density (+´÷≠)"
      max ⇐ 1
      log ⇐ 0 ⋄ Trans ⇐ 1.6⊸√⌾(1-˜÷)
      range ⇐ ×˜⌾(1-˜÷) ↕⊸∾⊸÷ 20
    }
    output ⇐ {denom ⇐ "input"}

    Measure ⇐ { 𝕊⟨len⟩: len⇐
      TimeParams ⇐ { ⟨/, len↑·/⁼(⌊0.5+𝕩×len) •rand.Subset len˙⟩ }
      timeInit ⇐ (len<1e3)⊑⟨0‿0.8,1‿2‿0‿4‿6‿9‿3‿7‿8‿5÷10⟩
    }
  }
  {
    ext ⇐ "avg"
    plotname ⇐ "Indices from uniform random list"

    params ⇐ ⟨sizes⟩
    input ⇐ {
      name ⇐ "Average (+´÷≠)"
      max ⇐ 100
      range ⇐ scale.E13 max
    }
    output ⇐ {denom ⇐ "output"}

    Measure ⇐ { 𝕊⟨l⟩: Len⇐l⊸×
      TimeParams ⇐ { ⟨/, l •rand.Range (1+2×𝕩)˙⟩ }
      timeInit ⇐ (l<1e3)⊑⟨2‿31,4‿37‿1‿6‿3‿11‿2⟩
    }
  }
  {
    ext ⇐ "inverse"
    plotname ⇐ "Index list to counts (/⁼)"
    params ⇐ ⟨{
      name ⇐ "Max"
      range ⇐ 10⋆exp←1‿2‿3‿4‿5
      labels ⇐ ("max 1e"∾•Repr)¨ exp
      Order ⇐ ⌽
    }⟩

    input ⇐ {
      name ⇐ "Input length"
      max ⇐ 1e7
      range ⇐ scale.E23 max
    }
    output ⇐ {max ⇐ 100, denom ⇐ "input"}

    Measure ⇐ { 𝕊 ⟨max⟩:
      ⟨Rand⟩ ← ⟨max⟩ •Import "../measure/gen.bqn"
      TimeParams ⇐ { ⟨/⁼, 𝕩 Rand max˙⟩ }
      timeInit ⇐ 1e5‿1‿1e3
    }
  }
⟩
