# Monadic /

⟨RandBool⟩ ← •Import "../measure/gen.bqn"
scale ← •Import"../measure/scale.bqn"

GetSizes ← { 𝕊 exp:
  name ⇐ "Size"
  range ⇐ 10⋆exp
  labels ⇐ ("length 1e"∾•Repr)¨ exp
}

sizes ← GetSizes 2‿4‿6

maxes ← {
  name ⇐ "Max"
  range ⇐ 10⋆exp←1‿2‿3‿4‿5
  labels ⇐ ("max 1e"∾•Repr)¨ exp
  Order ⇐ ⌽
}

Bench ← {
  params‿input‿measure ⇐ ext‿plotname ← opts ← 𝕩
  name ⇐ "indices-"∾ext

  result ⇐ ({⟨r⇐output⟩:⟨r⟩;⟨⟩}𝕩) •Import "../params/ns_v.bqn"

  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    key ⇐ {labels⇐⋈"/"} ⊣´ params
  }
}

Inverse ← { 𝕊 e‿desc‿GetGen:
  ext ⇐ "inverse-"∾e
  plotname ⇐ desc
  params ⇐ ⟨maxes⟩
  input ⇐ {
    name ⇐ "Input length"
    max ⇐ 1e7
    range ⇐ scale.Q13 max
  }
  output ⇐ {max ⇐ 100, denom ⇐ "input"}

  Measure ⇐ { 𝕊 ⟨max⟩:
    gen ← GetGen ⟨max⟩ •Import "../measure/gen.bqn"
    TimeParams ⇐ { ⟨/⁼, 𝕩 Gen max˙⟩ }
    timeInit ⇐ 1e5‿1‿1e3
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
      FilterMin ⇐ ¬∊⟜0‿1
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

  Inverse "rand"  ‿"Index list to counts (/⁼)"       ‿{𝕩.Rand}
  Inverse "sorted"‿"Sorted indices to counts with /⁼"‿{𝕩.RandSort}
  {
    ext ⇐ "inverse-runs"
    len ← 10⋆exp←4
    plotname ⇐ "1e"∾(•Repr exp)∾" indices to counts with /⁼"
    params ⇐ ⟨maxes⟩
    input ⇐ {
      name ⇐ "Average run length"
      range ⇐ (⌊0.5⊸+)⌾(len⊸÷) 1.3 scale._exp2d max ⇐ len
    }
    output ⇐ {denom ⇐ "input"}
    Measure ⇐ { 𝕊 ⟨max⟩: len⇐len
      ⟨Rand, Partition⟩ ← ⟨max⟩ •Import "../measure/gen.bqn"
      TimeParams ⇐ {
        r ← ⌊0.5+len÷𝕩 ⋄ m1 ← max-1  # Number of runs, max value
        # Always include m1; avoid ever repeating a value
        RunVals ← max | (1 Rand r˙) (⊢+m1-⊑) 0 ∾ ·+` 1 + (r-1) Rand m1˙
        ⟨/⁼, (r Partition len˙) / RunVals⟩
      }
    }
  }
  {
    ext ⇐ "inverse-slope"
    len ← 10⋆exp←4
    plotname ⇐ "Sorted indices to counts with /⁼"
    params ⇐ ⟨{name‿range‿labels⇐𝕩 ⋄ Order⇐⌽} GetSizes 3‿4‿5‿6⟩
    input ⇐ {
      name ⇐ "Range / length"
      range ⇐ 2 × ↕⊸∾⊸÷ 15
      log ⇐ 0 ⋄ FilterMin ⇐ 0⊸<
    }
    output ⇐ {denom ⇐ "input"}
    Measure ⇐ { 𝕊 ⟨len⟩: len⇐
      ⟨RandSort⟩ ← ⟨len⟩ •Import "../measure/gen.bqn"
      TimeParams ⇐ { ⟨/⁼, len RandSort (1⌈⌊0.5+𝕩×len)˙⟩ }
      timeInit ⇐ (len<1e3)⊑⟨0.2‿1,1‿4‿10‿5‿0‿6‿8‿2÷10⟩
    }
  }
⟩
