# Self-search: one-argument ⊐⊒∊

types‿Bench ← "common/self.bqn" •Import˜ {
  name ⇐ "selfsearch"
  title ⇐ "Self-search of"
  fns ⇐ ⊐‿⊒‿∊‿⍷
}

Bench¨ ∾ ⟨
  {
    ext  ⇐ "rand-"  ∾𝕩.disp
    desc ⇐ "random "∾𝕩.label
    ⟨GetGen⟩ ⇐ 𝕩
  }¨ types.range
  {
    ext  ⇐ "sort-"  ∾𝕩.disp
    desc ⇐ "sorted "∾𝕩.label
    GetGen ⇐ {•internal.Squeeze∘∧𝕏} 𝕩.GetGen
  }¨ types.range
⟩
