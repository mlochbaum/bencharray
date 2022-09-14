# Monadic arithmetic functions

basename ← "arithm"

ns_v   ← •Import "../params/ns_v.bqn"
types  ← •Import "../params/numtype.bqn"
GetFns ← ⋈ •Import "../params/arith.bqn"˙
GetInp ← {name⇐"Length" ⋄ range⇐𝕩}

Bench ← {
  ext‿fns‿range‿plotpre‿plotname ← 𝕩
  name ⇐ basename∾ext
  params ⇐ types ⋈ fnobjs ← GetFns fns
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
    labels ⇐ {𝕩.Disp¨ 𝕩.num} fnobjs
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
