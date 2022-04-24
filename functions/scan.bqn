# / with boolean argument

basename ← "scan"

⟨RandBool⟩ ← •Import "../measure/gen.bqn"
ns ← •Import "../params/ns_v.bqn"
cputypes  ← •Import "../params/cputype.bqn"

Bool ← {
  name ⇐ basename∾𝕨
  params ⇐ ⟨⟨𝕩⟩ •Import "../params/logic.bqn"⟩
  result ⇐ ns

  input ⇐ {
    name ⇐ "Size"
    max ⇐ 1e7
    range ⇐ 1 ↓ (•Import"../measure/scale.bqn").E13 max
  }

  PlotPre ⇐ ⊢
  Measure ⇐ { 𝕊 ⟨fn⟩:
    TimeParams ⇐ { ⟨Fn`, RandBool∘𝕩⟩ }
    timeInit ⇐ 1e5‿1‿1e3
  }

  plotOpts ⇐ {
    title ⇐ "Scan F` of boolean list"
    x ⇐ input
    y ⇐ result
    labels ⇐ {𝕩.Disp¨ 𝕩.range} ⊑params
    ChangeBounds ⇐ x.max‿y.max⊸⌊
  }
}

Summary ← {
  name ⇐ basename∾𝕨
  types ← cputypes ⋄ fns ← ⟨𝕩⟩ •Import "../params/arith.bqn"
  params ⇐ types‿fns
  result ⇐ ns

  input ⇐ { name⇐"Length" ⋄ Range⇐{<(2⋆3+15)÷𝕩.size} }
  PlotPre ⇐ {> types.num⊸⋈¨ <˘⍉1⊑⎉1𝕩}
  Measure ⇐ { 𝕊 type‿fn:
    ⟨size,GetGen⟩ ← type ⋄ size⇐
    TimeParams ⇐ { ⟨Fn`, GetGen𝕩⟩ }
  }

  plotOpts ⇐ {
    title ⇐ "Scan F` of numeric list, 32KB"
    x ⇐ types
    y ⇐ result
    labels ⇐ {𝕩.Disp¨ 𝕩.range} fns
  }
}

⟨
  "-boolean" Bool ∧‿∨‿=‿≠‿+‿-
  "-boolcmp" Bool <‿>‿≤‿≥
  "-arith" Summary +‿-‿⌈‿⌊
  "-slow"  Summary ×‿÷‿⋆‿|
⟩
