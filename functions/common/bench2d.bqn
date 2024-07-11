# Benchmarks on 2D arrays with 1e4 total elements
⟨basename⟩ ← ⊑•args
tname ← (-´"Aa")⊸+⌾⊑ basename

scales     ← •Import "../../measure/scale.bqn"
ns         ← •Import "../../params/ns_v.bqn"

Bench2d ← { mext‿mod‿mname 𝕊 dat:
  ⟨params⟩ ⇐ ext‿fname‿arg‿GetTime ← dat
  arg " "⊸∾⍟(0<≠)↩ ⋄ ext "-"⊸∾⍟(0<≠)↩
  plotname ⇐ ∾tname   ‿mext‿" "‿fname‿mname‿" of"‿arg‿" rank 2 array"
  name     ⇐ ∾basename‿mext‿"-2d"‿ext
  total ← 10⋆e←4
  input ⇐ {
    name ⇐ "Width"
    range ⇐ 1.5 scales._exp2d total
    FilterMin ⇐ ¬∊⟜(0‿¯1⊏range)
  }
  result ⇐ ns
  Measure ⇐ {
    Flip ← total⌈∘÷⊢  # Length of other dimension
    Len ⇐ Flip⊸×
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
