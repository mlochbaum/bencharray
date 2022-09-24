# Select function ⊏

types ← •Import "../params/numtype.bqn"

Bench ← {
  input‿Measure ⇐ ext‿plotname ← 𝕩
  name ⇐ "select-"∾ext

  result ⇐ ({⟨r⇐denom⟩:⟨{denom⇐r}⟩;⟨⟩}𝕩) •Import "../params/ns_v.bqn"
  result.SetMin 0.4
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
    ext ⇐ "many"
    plotname ⇐ "Selecting 1e6 elements with ⊏"
    input ⇐ {
      name ⇐ "Right argument length"
      max ⇐ 1e6
      range ⇐ (•Import"../measure/scale.bqn").E13 max
    }
    denom ⇐ "selection"
    Measure ⇐ { 𝕊 ⟨type⟩:
      len ⇐ 1e6
      TimeParams ⇐ {
        Ind ← (⟨𝕩⟩•Import"../measure/gen.bqn").Rand
        ⟨⊏, len Ind 𝕩˙, type.GetGen𝕩⟩
      }
    }
  }
  {
    ext ⇐ "permute"
    plotname ⇐ "Permuting a list with ⊏"
    input ⇐ {
      name ⇐ "Length"
      max ⇐ 1e6
      range ⇐ (•Import"../measure/scale.bqn").E23 max
    }
    Measure ⇐ { 𝕊 ⟨type⟩:
      TimeParams ⇐ { ⟨⊏, •rand.Deal𝕩˙, type.GetGen𝕩⟩ }
    }
  }
⟩
