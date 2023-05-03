# Table modifier

basename ← "table"

ns     ← {denom⇐"output"} •Import "../params/ns_v.bqn"
types  ← •Import "../params/numtype.bqn"
ctypes ← •Import "../params/cputype.bqn"
scales ← •Import "../measure/scale.bqn"

FullName ← "min"‿"less"‿"plus" ⊑˜ "⌊<+"⊸⊐⌾<
Bench ← { over 𝕊 fname:
  total ← •ParseFloat tname←"1e4"
  Flip ← total⌈∘÷⊢  # Length of other dimension
  fn ← •BQN ⥊fname
  name ⇐ ∾⟨basename,"-", FullName fname, over/"-over"⟩
  plotname ← ∾⟨"Arithmetic ",fname,"⌜ ",over/"(overflow) "
               "with ",tname,"-element result"⟩

  params ⇐ ⟨(over<fname='+')⊑types‿ctypes⟩
  input ⇐ {
    name ⇐ "Right argument length"
    range ⇐ 1.2 scales._exp2d total
  }
  result ⇐ ns
  Measure ⇐ { 𝕊 ⟨type⟩:
    getGen ← {⟨G⇐GetGenSmall⟩: over? G ; 𝕩.GetGen} type
    Len ⇐ Flip⊸×
    TimeParams ⇐ { ⟨Fn⌜⟩ ∾ GetGen¨ Flip⊸⋈ 𝕩 }
  }
  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    key ⇐ ⊑params
  }
}

(0 Bench¨ "⌊<+") ∾ 1 Bench '+'
