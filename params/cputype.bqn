# CPU types: ints and floats
name ⇐ "Type"
num ⇐ ↕4
log ⇐ 0

range ⇐ {
  float ⇐ 64 = size ⇐ 2⋆3+𝕩
  max ⇐ (¬float) × 1-˜2⋆size-1
  disp ⇐ (float⊑"if") ∾ •Repr size
  label ⇐ ∾⟨•Repr size÷8, "-byte ", float⊑"int"‿"float"⟩

  # Random numbers
  GetGen ⇐ {
    ⟨Rand⟩ ← ⟨𝕩⟩ •Import "../measure/gen.bqn"
    n ← (¬float) × 2⋆size
    •internal.Squeeze ((float+n)÷2) -˜ 𝕩 Rand n˙
  }

  # Random numbers that won't overflow for +-
  GetGenSmall ⇐ {
    ⟨Rand⟩ ← ⟨𝕩⟩ •Import "../measure/gen.bqn"
    (⌈(1⌈max)÷2) -˜ 𝕩 Rand max˙
  }
}¨ num

Disp ⇐ {𝕩.disp}⊑⟜range
labels ⇐ {𝕩.label}¨range
