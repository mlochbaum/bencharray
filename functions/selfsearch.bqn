# Self-search: one-argument ⊐⊒∊⍷

types‿Bench‿BenchLenAll ← "common/self.bqn" •Import˜ {
  name ⇐ "selfsearch"
  title ⇐ "Self-search of"
  fns ⇐ ⊐‿⊒‿∊‿⍷
}

∾ ⟨
  "rand"‿"random" BenchLenAll 1e7‿{𝕩.GetGen}
  "sort"‿"sorted" BenchLenAll 1e7‿{{•internal.Squeeze∘∧𝕏} 𝕩.GetGen}
⟩
