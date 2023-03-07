# CPU types: ints and floats
name ⇐ "Type" ⊣´ •args
num ⇐ ↕4
log ⇐ 0

range ⇐ {
  float ⇐ 64 = size ⇐ 2⋆3+𝕩
  max ⇐ (¬float) × 1-˜2⋆size-1
  disp ⇐ (float⊑"if") ∾ •Repr size
  label ⇐ ∾⟨•Repr size÷8, "-byte ", float⊑"int"‿"float"⟩

  # Random numbers
  range ← (¬float) × 2⋆size
  _ggg0 ← { 𝕨 Rfn _𝕣 𝕩:
    rand ← Rfn ⟨𝕨⊣𝕩⟩ •Import "../measure/gen.bqn"
    𝕩 Rand range˙
  }
  _ggg ← { {•internal.Squeeze 𝕏-((float+range)÷2)˙}∘𝔽 _ggg0 }
  GetGen ⇐ {𝕩.Rand}_ggg
  getGenUnique ⇐ {size<32 ? {𝕩.RandUnique}_ggg ; GetGen} # Large-range •rand.Deal unimplemented
  GetGenSorted ⇐ {∧𝕏}∘{size≤32 ? GetGen ; {¯0.5+`⊣÷˜𝕩.Rand⟜0}_ggg0}

  # Random numbers that won't overflow for +-
  GetGenSmall ⇐ {
    ⟨Rand⟩ ← ⟨𝕨⊣𝕩⟩ •Import "../measure/gen.bqn"
    (⌈(1⌈max)÷2) -˜ 𝕩 Rand max˙
  }

  maxrange ⇐ float ⊑ ⟨2⋆size,∞⟩
}¨ num

Disp ⇐ {𝕩.disp}⊑⟜range
labels ⇐ {𝕩.label}¨range
