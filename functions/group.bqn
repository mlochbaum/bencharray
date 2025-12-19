# Group ⊔

ns    ← ⟨{denom⇐"input"}⟩ •Import "../params/ns_v.bqn"
types ← •Import "../params/numtype.bqn"
scale ← •Import"../measure/scale.bqn"
sizes ← {
  name ⇐ "Size"
  range ⇐ 10⋆exp←2‿3‿4‿6
  labels ⇐ ("length 1e"∾•Repr)¨ exp
}

Bench ← { isInd‿nameext‿params‿_getMeasure 𝕊 𝕩:
  ⟨input⟩ ⇐ ext‿plotname‿GetGrGen ← 𝕏 isInd
  name ⇐ ∾"group-"‿nameext‿ext
  result ⇐ ns
  params⇐
  Measure ⇐ GetGrGen _getMeasure
  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    key ⇐ ⊑params
  }
}
withGroup ← {
  isInd ⇐ 0
  nameext ⇐ ""
  params ⇐ ⟨types⟩
  l ← 1e5
  _getMeasure ⇐ { GetGrGen _𝕣 ⟨type⟩:
    gen ← GetGrGen len ⇐ l
    TimeParams ⇐ { ⟨⊔, Gen 𝕩, type.GetGen len⟩ }
  }
}
withInds ← {
  isInd ⇐ 1
  nameext ⇐ "indices-"
  params ⇐ ⟨sizes⟩
  _getMeasure ⇐ { GetGrGen _𝕣 ⟨len⟩:
    len⇐
    gen ← GetGrGen len
    TimeParams ⇐ { ⟨⊔, Gen 𝕩⟩ }
  }
}

Density ← { 𝕊 i:
  ext ⇐ "density"
  plotname ⇐ i⊑⟨"1e5 elements to 1e3 groups with ⊔"
                "n elements to n/100 index groups with ⊔"⟩
  input ⇐ {
    name ⇐ (i⊑"Left argument n"‿"N")∾"on-negative density"
    max ⇐ 1
    log ⇐ 0 ⋄ Trans ⇐ 1.6⊸√
    range ⇐ ×˜ ↕⊸∾⊸÷ 10
  }
  GetGrGen ⇐ { 𝕊 len:
    n ← len ÷ 100
    base ← len (⟨n⟩•Import"../measure/gen.bqn").Rand n
    { {¯1¨⌾(𝕩⊸⊏)base} (⌊0.5+len×¬𝕩) •rand.Subset len˙ }
  }
}
Range ← { 𝕊 e‿verb‿ProcW: { 𝕊 i:
  ext ⇐ "range"∾e
  plotname ⇐ i⊑⟨verb∾"ing 1e5 elements with ⊔"
                verb∾"ing n indices with ⊔"⟩
  input ⇐ {
    name ⇐ "Number of groups"
    max ⇐ 1e6
    range ⇐ 10‿6 scale.E23 max
    FilterMin ⇐ 1⊸<
  }
  GetGrGen ⇐ { 𝕊 len:
    { ProcW len (⟨𝕩⟩•Import"../measure/gen.bqn").Rand 𝕩˙ }
  }
}}

withGroup‿withInds Bench⌜ ⟨
  density
  Range ""     ‿"Group"    ‿⊢
  Range "-sort"‿"Partition"‿∧
⟩
