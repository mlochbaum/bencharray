# CPU types: ints and floats
name ⇐ "Type"
num ⇐ ↕4
range ⇐ {
  float ⇐ 64 = size ⇐ 2⋆3+𝕩
  max ⇐ (¬float) × 1-˜2⋆size-1
  disp ⇐ (float⊑"if") ∾ •Repr size
  label ⇐ ∾⟨•Repr size÷8, "-byte ", float⊑"int"‿"float"⟩
}¨ num
log ⇐ 0
Disp ⇐ {𝕩.disp}⊑⟜range
