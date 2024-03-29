# Monadic arithmetic functions

basename ← "arithm"

ns_v   ← •Import "../params/ns_v.bqn"
types  ← •Import "../params/numtype.bqn"
GetFns ← ⋈ •Import "../params/arith.bqn"˙
GetInp ← {name⇐"Length" ⋄ range⇐𝕩}

Bench ← {
  ext‿fns‿range‿plotpre‿plotname ← 𝕩
  name ⇐ basename∾ext
  params ⇐ ⟨types, GetFns fns⟩
  input ⇐ GetInp range
  result ⇐ ns_v
  Measure ⇐ { 𝕊 type‿fn:
    ⟨size,GetGen⟩ ← type ⋄ size⇐
    TimeParams ⇐ { ⟨fn, GetGen𝕩⟩ }
  }
  PlotPre⇐
  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ types
    y ⇐ result
    key ⇐ 1⊑params
  }
}
Summary ← Bench∘{
  ext⇐𝕨 ⋄ fns‿plotname ⇐ 𝕩
  Range ⇐ {<(2⋆3+15)÷𝕩.size}
  PlotPre ⇐ {> types.num⊸⋈¨ <˘⍉1⊑⎉1𝕩}
}

⟨
  "-simple"  Summary ⟨-‿¬‿×‿|‿⌊‿⌈,  "Monadic arithmetic, 32KB"⟩
  "-slow"    Summary ⟨(⋆⁼)‿⋆‿√‿÷,   "Slow monadic arithmetic, 32KB"⟩
⟩
