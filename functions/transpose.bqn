# Transpose ⍉

ns ← •Import "../params/ns_v.bqn"
types ← •Import "../params/numtype.bqn"
scales ← •Import "../measure/scale.bqn"

{
  name ⇐ "transpose-2d"
  total ← 10⋆e←4
  plotname ← ∾"Transposing 1e"‿('0'+e)‿" total elements with ⍉"
  params ⇐ ⟨types⟩
  input ⇐ {
    name ⇐ "Width"
    range ⇐ scales.E2d11 total
    FilterMin ⇐ ¬∊⟜(0‿¯1⊏range)
  }
  result ⇐ ns
  Measure ⇐ { 𝕊 ⟨type⟩:
    Flip ← total⌈∘÷⊢  # Length of other dimension
    Len ⇐ Flip⊸×
    TimeParams ⇐ { ⟨⍉, type.GetGen Flip⊸⋈ 𝕩⟩ }
    timeInit ⇐ 1e5‿1‿1e3
  }
  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    key ⇐ ⊑params
  }
}
