# Scan modifier

basename ← "scan"

⟨RandBool⟩ ← •Import "../measure/gen.bqn"
scales     ← •Import "../measure/scale.bqn"
ns         ← •Import "../params/ns_v.bqn"
cputypes   ← •Import "../params/cputype.bqn"

MeasureArith ← { 𝕊 type‿fn:
  ⟨size,GetGen⟩ ← type ⋄ size⇐
  TimeParams ⇐ { ⟨Fn`, GetGen𝕩⟩ }
}

Scale ← {
  name ⇐ "Length"
  range ⇐ 1 ↓ scales.E13 max ⇐ 𝕩
}

Detail ← {
  params‿input‿GetTime ⇐ ext‿plotname ← 𝕩
  name ⇐ basename∾ext
  result ⇐ ns
  Measure ⇐ {
    timeParams ⇐ GetTime 𝕩
    timeInit ⇐ 1e5‿1‿1e3
  }
  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    ⟨labels⟩ ⇐ ⊑params
    ChangeBounds ⇐ x.max‿y.max⊸⌊
  }
}

Bool ← Detail∘{
  ext ⇐ 𝕨 ⋄ plotname ⇐ "Scan F` of boolean list"
  params ⇐ ⟨⟨𝕩⟩ •Import "../params/logic.bqn"⟩
  input ⇐ Scale 1e7
  GetTime ⇐ { 𝕊 ⟨fn⟩: { ⟨Fn`, RandBool∘𝕩⟩ } }
}

Arith ← Detail∘{
  ext ⇐ 𝕨 ⋄ fn ← 𝕩
  plotname ⇐ "Scan "∾(•Repr fn)∾"` of numeric list"
  params ⇐ ⟨cputypes⟩
  input ⇐ Scale 1e5
  GetTime ⇐ {𝕩.TimeParams}∘MeasureArith ∾⟜⟨fn⟩
}

Summary ← {
  name ⇐ basename∾𝕨
  types ← cputypes ⋄ fns ← ⟨𝕩⟩ •Import "../params/arith.bqn"
  params ⇐ types‿fns
  result ⇐ ns

  input ⇐ { name⇐"Length" ⋄ Range⇐{<(2⋆3+15)÷𝕩.size} }
  PlotPre ⇐ {> types.num⊸⋈¨ <˘⍉1⊑⎉1𝕩}
  Measure ⇐ MeasureArith

  plotOpts ⇐ {
    title ⇐ "Scan F` of numeric list, 32KB"
    x ⇐ types
    y ⇐ result
    ⟨labels⟩ ⇐ fns
  }
}

⟨
  "-boolean" Bool ∧‿∨‿=‿≠‿+‿-
  "-boolcmp" Bool <‿>‿≤‿≥
  "-arith" Summary +‿-‿⌈‿⌊
  "-slow"  Summary ×‿÷‿⋆‿|
  "-plus"  Arith {+}
  "-min"   Arith {⌊}
⟩
