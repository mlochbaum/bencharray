# Dyadic arithmetic functions

basename ← "arith"

ns_v   ← •Import "../params/ns_v.bqn"
scales ← •Import "../measure/scale.bqn"
types‿itypes ← •Import⟜"../params/cputype.bqn"¨ ⟨⟩‿⟨"Input type"⟩
typeb  ← •Import "../params/numtype.bqn"
GetFns ← ⋈ •Import "../params/arith.bqn"˙
GetInp ← {name⇐"Length" ⋄ range⇐𝕩}

# Measurement functions
MSmall ← { 𝕊 type‿fn:
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
_mGen ← { GenPair _𝕣 type‿fn:
  ⟨size,GetGen⟩ ← type ⋄ size⇐
  TimeParams ⇐ { ⟨fn⟩∾getGen GenPair 𝕩 }
}
MLarge ← (⋈˜{𝕎𝕩})_mGen
MLScal ← {⟨{⊑𝕏}𝕎1,𝕎𝕩⟩}_mGen

Bench ← {
  Measure‿PlotPre ⇐ ext‿fns‿range‿plotname‿itype ← 𝕩
  name ⇐ basename∾ext
  params ⇐ ⟨types, GetFns fns⟩
  input ⇐ GetInp range
  result ⇐ ns_v
  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ itype ⊑ types‿itypes
    y ⇐ result
    key ⇐ 1⊑params
  }
}
Summary ← Bench∘{
  ext⇐𝕨 ⋄ fns‿measure‿itype‿plotname ⇐ 𝕩
  Range ⇐ {<(2⋆3+15)÷𝕩.size}
  PlotPre ⇐ {> types.num⊸⋈¨ <˘⍉1⊑⎉1𝕩}
}

Bench2d_sub ← { 𝕊 ext‿desc‿fn‿isadd‿over‿total‿axes:
  plotname ⇐ desc∾" on list and table"
  name     ⇐ basename∾ext
  params ⇐ ⟨(over<isadd)⊑typeb‿types⟩
  input ⇐ {
    name ⇐ "Width"
    range ⇐ scales.E2d11 total
  }
  result ⇐ ns_v
  Measure ⇐ { 𝕊 ⟨type⟩:
    getGen ← {⟨G⇐GetGenSmall⟩: ¬over? G ; 𝕩.GetGen} type
    Flip ← total⌈∘÷⊢  # Length of other dimension
    Len ⇐ Flip⊸×
    TimeParams ⇐ { ⟨fn⟩ ∾ GetGen¨ axes↑¨<𝕩 }∘(Flip⊸⋈)
  }
  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    key ⇐ ⊑params
  }
}
Lead ← { ext1 𝕊 fn‿fname‿over‿total:
  fn‿over‿total⇐ ⋄ isadd⇐{+}≡fn
  desc ⇐ "Leading-axis "∾fname
  ext  ⇐ "-lead"∾ext1
  axes ⇐ 1‿2
}
Rank1 ← { ext1 𝕊 fn0‿fname‿over‿total:
  over‿total⇐
  Fn ⇐ Fn0⎉1 ⋄ isadd⇐{+}≡fn0
  desc ⇐ "Arithmetic "∾(∧`' '⊸≠)⊸(/∾"⎉1"∾¬⊸/)fname
  ext  ⇐ "-rank"∾ext1
  axes ⇐ ¯1‿2
}
Bench2d ← Lead ⋈○Bench2d_sub Rank1

∾⟨
  "-summary" Summary ⟨×‿+‿⌊‿<,      MSmall, 0, "Arithmetic with no overflow, 32KB"⟩
  "-small"   Summary ⟨×‿+‿-‿⌊‿⌈,    MSmall, 0, "Arithmetic with no overflow, 32KB"⟩
  "-over"    Summary ⟨×‿+‿-,        MLarge, 1, "Arithmetic with overflow, 32KB"⟩
  "-scal"    Summary ⟨×‿+‿⌊‿<,      MLScal, 1, "Scalar-list arithmetic allowing overflow, 32KB"⟩
  "-compare" Summary ⟨<‿>‿=‿≠‿≤‿≥,  MLarge, 0, "Comparisons, 32KB"⟩
  "-slow"    Summary ⟨(⋆⁼)‿⋆‿√‿|‿÷, MLarge, 1, "Slow arithmetic, 32KB"⟩
  "-min"     Bench2d ⟨⌊, "⌊",0, 1e4⟩
  "-less"    Bench2d ⟨<, "<",0, 1e4⟩
  "-plus"    Bench2d ⟨+, "+",0, 1e4⟩
  "-plus-over" Bench2d ⟨+, "+ (overflow)",1, 1e4⟩
⟩
