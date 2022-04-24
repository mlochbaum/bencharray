# / with boolean argument

⟨RandBool⟩ ← •Import "../measure/gen.bqn"

Bench ← {
  name‿params‿input‿result‿measure ⇐ 𝕩
  ⟨plotname⟩ ← 𝕩

  PlotPre ⇐ ⊢
  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    labels ⇐ {𝕩.Disp¨ 𝕩.range} ⊑params
    ChangeBounds ⇐ x.max‿y.max⊸⌊
  }
}

Bool ← {
  name ⇐ 𝕨
  plotname ⇐ "Scan F` of boolean list"
  params ⇐ ⟨⟨𝕩⟩ •Import "../params/logic.bqn"⟩
  result ⇐ •Import "../params/ns_v.bqn"

  input ⇐ {
    name ⇐ "Size"
    max ⇐ 1e7
    range ⇐ 1 ↓ (•Import"../measure/scale.bqn").E13 max
  }

  Measure ⇐ { 𝕊 ⟨fn⟩:
    TimeParams ⇐ { ⟨Fn`, RandBool∘𝕩⟩ }
    timeInit ⇐ 1e5‿1‿1e3
  }
}

Bench¨ ⟨
  "scan-boolean" Bool ∧‿∨‿=‿≠‿+‿-
  "scan-boolcmp" Bool <‿>‿≤‿≥
⟩
