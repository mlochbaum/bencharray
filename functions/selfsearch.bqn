# Self-search: one-argument ⊐⊒∊⍷

types‿Bench‿BenchLenAll‿BenchFixLen ← "common/self.bqn" •Import˜ {
  name ⇐ "selfsearch"
  title ⇐ "Self-search of"
  fns ⇐ ⊐‿⊒‿∊‿⍷
}

E13‿E23 ← •Import "../measure/scale.bqn"

∾ ⟨
  "pair"‿"shuffled pairs," BenchLenAll 1e7‿E13‿{⊢ {•rand.Deal∘≠⊸⊏𝕨⥊𝕏} ·𝕩.GetGen 1⌈⌊∘÷⟜2}
  "rand"‿"random"          BenchLenAll 1e7‿E23‿{𝕩.GetGen}
  "sort"‿"sorted"          BenchLenAll 1e7‿E23‿{{•internal.Squeeze∘∧𝕏} 𝕩.GetGen}
  "unique"‿"1e5 repetitive" BenchFixLen {
    len ⇐ 1e5
    TypeToGen ⇐ {{len(•rand.Range⟜≠⊏⊢)𝕏} 𝕩.GetGen}
    input ⇐ {
      name ⇐ "Unique values"
      range ⇐ (•Import "../measure/scale.bqn").E23 max ⇐ len
    }
  }
⟩
