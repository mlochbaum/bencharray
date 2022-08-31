# Arithmetic functions

basename ← "arith"

ns_v   ← •Import "../params/ns_v.bqn"
types  ← •Import "../params/cputype.bqn"
GetFns ← ⋈ •Import "../params/arith.bqn"˙
GetInp ← {name⇐"Length" ⋄ range⇐𝕩}

Measure ← { 𝕊 type‿fn:
  ⟨float,size,max,GetGen⇐GetGenSmall⟩ ← type ⋄ size⇐
  TimeParams ⇐ {
    # Use one generator for both arguments
    float ∨ ×˙⊸≠fn ? l ← 1‿2/⟨fn, GetGen𝕩⟩ ;
    # In integer × arguments need to interact to suppress overflow: use
    # two parallel generators but run each twice so each argument sees
    # both sets of random numbers
    ⟨fn⟩ ∾ ⊣‿{•internal.Squeeze(××(⌊max÷|𝕨)⌊|)𝕩} {𝕎○𝕏˜}⟜GetGen¨ <𝕩
  }
}

Bench ← {
  ext‿fns‿range‿plotpre‿plotname ← 𝕩
  name ⇐ basename∾ext
  params ⇐ types ⋈ fnobjs ← GetFns fns
  input ⇐ GetInp range
  result ⇐ ns_v
  Measure ⇐ Measure
  PlotPre⇐
  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ types
    y ⇐ result
    labels ⇐ {𝕩.Disp¨ 𝕩.num} fnobjs
  }
}
Summary ← Bench∘{
  ext⇐𝕨 ⋄ fns‿plotname ⇐ 𝕩
  Range ⇐ {<(2⋆3+15)÷𝕩.size}
  PlotPre ⇐ {> types.num⊸⋈¨ <˘⍉1⊑⎉1𝕩}
}

⟨
  "-summary" Summary ⟨×‿+‿⌊‿<,      "Arithmetic with no overflow, 32KB"⟩
  "-small"   Summary ⟨×‿+‿-‿⌊‿⌈,    "Arithmetic with no overflow, 32KB"⟩
  "-compare" Summary ⟨<‿>‿=‿≠‿≤‿≥,  "Comparisons, 32KB"⟩
  "-slow"    Summary ⟨(⋆⁼)‿⋆‿√‿|‿÷, "Slow arithmetic, 32KB"⟩
⟩
