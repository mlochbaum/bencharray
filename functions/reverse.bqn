types   ← •Import "../params/numtype.bqn"
bench2d ← {basename⇐"reverse"} •Import "common/bench2d.bqn"

dat ← {
  Fn ← ⌽
  ext⇐"" ⋄ fname ⇐ •Repr fn ⋄ arg ⇐ ""
  params ⇐ ⟨types⟩
  GetTime ⇐ { mod 𝕊 ⟨type⟩: { ⟨Fn _mod, type.GetGen𝕩⟩ } }
}

Bench2d⟜dat¨ ⟨
  ""      ‿{𝔽}‿""
  "-cells"‿ ˘ ‿"˘"
⟩
