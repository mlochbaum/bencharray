# / with boolean argument

⟨RandBool⟩ ← •Import "../measure/gen.bqn"
scale ← •Import"../measure/scale.bqn"

Bench ← {
  params‿input‿measure ⇐ ext‿plotname ← 𝕩
  name ⇐ "indices-"∾ext

  result ⇐ ⟨{⟨r⇐maxtime⟩:r;10}𝕩⟩ •Import "../params/ns_v.bqn"

  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    labels ⇐ ({label⇐⋈"/"} ⊣´ params).label
    ChangeBounds ⇐ x.max‿y.max⊸⌊
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

    measure ⇐ {
      TimeParams ⇐ { ⟨/, RandBool∘𝕩⟩ }
      timeInit ⇐ 1e5‿1‿1e3
    }
  }
  {
    ext ⇐ "where-density"
    plotname ⇐ "Indices from boolean lists"

    params ⇐ ⟨{
      name ⇐ "Size"
      range ⇐ 10⋆exp←2‿4‿6
      label ⇐ ("length 1e"∾•Repr)¨ exp
    }⟩

    input ⇐ {
      name ⇐ "Density (+´÷≠)"
      max ⇐ 1
      log ⇐ 0 ⋄ Trans ⇐ 1.6⊸√⌾(1-˜÷)
      range ⇐ ×˜⌾(1-˜÷) ↕⊸∾⊸÷ 20
    }

    Measure ⇐ { 𝕊⟨len⟩: len⇐
      TimeParams ⇐ { ⟨/, len↑·/⁼(⌊0.5+𝕩×len) •rand.Subset len˙⟩ }
      timeInit ⇐ (len<1e3)⊑⟨0‿0.8,1‿2‿0‿4‿6‿9‿3‿7‿8‿5÷10⟩
    }
  }
  {
    ext ⇐ "inverse"
    plotname ⇐ "Index list to counts (/⁼)"
    params ⇐ ⟨{
      name ⇐ "Max"
      range ⇐ 10⋆exp←2‿3‿4‿5
      label ⇐ ("max 1e"∾•Repr)¨ exp
    }⟩

    input ⇐ {
      name ⇐ "Input length"
      max ⇐ 1e7
      range ⇐ scale.E23 max
    }

    maxtime ⇐ 100
    Measure ⇐ { 𝕊 ⟨max⟩:
      ⟨Rand⟩ ← ⟨max⟩ •Import "../measure/gen.bqn"
      TimeParams ⇐ { ⟨/⁼, 𝕩 Rand max˙⟩ }
      timeInit ⇐ 1e5‿1‿1e3
    }
  }
⟩
