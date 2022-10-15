# Numeric types: boolean, ints, and floats
name‿log ⇐ ct ← •Import "cputype.bqn"
range ⇐ ct.range ∾˜ {
  float⇐0, size⇐1, max⇐1
  GetGen ⇐ {
    ⟨Rand⟩ ← ⟨𝕨⊣𝕩⟩ •Import "../measure/gen.bqn"
    •internal.Squeeze 𝕩 Rand 2˙
  }
  disp ⇐ "u1"
  label ⇐ "boolean"
}
num ⇐ ↕≠range
Disp ⇐ {𝕩.disp}⊑⟜range
labels ⇐ {𝕩.label}¨range
