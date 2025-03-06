# Benchmarks on 2D arrays with 1e4 total elements
⟨basename⟩ ← ⊑•args
tname ← (-´"Aa")⊸+⌾⊑ basename

scales     ← •Import "../../measure/scale.bqn"
ns         ← •Import "../../params/ns_v.bqn"

Bench2d ← { mext‿mod‿mname 𝕊 dat:
  ⟨params⟩ ⇐ ext‿GetTime ← dat
  plotname ⇐ {
    ⟨r⇐plotname⟩: r;
    ⟨fname,arg⟩: ∾⟨tname,mext," ",fname,mname
                   " of"," "⊸∾⍟(0<≠)arg," rank 2 array"⟩
  } dat
  name ⇐ ∾⟨basename,mext,"-2d","-"⊸∾⍟(0<≠)ext⟩
  total ← 10⋆e←4
  input ⇐ {
    name ⇐ "Width"
    range ⇐ scales.E2d11 total
    FilterMin ⇐ ¬∊⟜(0‿¯1⊏range)
  }
  result ⇐ {⟨r⇐result⟩:r; ns} dat
  getLen ← {⟨r⇐getLen⟩:r; ×} dat
  Measure ⇐ {
    Flip ← total⌈∘÷⊢  # Length of other dimension
    Len ⇐ Flip⊸GetLen
    TimeParams ⇐ (mod GetTime 𝕩)∘(Flip⊸⋈)
    timeInit ⇐ 1e5‿1‿1e3
  }
  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    key ⇐ ⊑params
  }
}
