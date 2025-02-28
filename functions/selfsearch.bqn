# Self-search: one-argument ⊐⊒∊⍷

BenchLenAll‿BenchFixLen‿BenchBool ← "common/self.bqn" •Import˜ {
  name ⇐ "selfsearch"
  title ⇐ "Self-search of"
  fns ⇐ ⊐‿⊒‿∊‿⍷
}

Q13‿E16‿E23 ← •Import "../measure/scale.bqn"

∾ ⟨
  "pair"‿"shuffled pairs," BenchLenAll 1e7‿Q13‿{⊢ {(≠|•rand.Deal∘𝕨)⊸⊏𝕏} ·𝕩.GetGen (𝕩.maxrange-1)⌊1⌈⌊∘÷⟜2}
  "rand"‿"random"          BenchLenAll 1e7‿Q13‿{𝕩.GetGen}
  "sort"‿"sorted"          BenchLenAll 1e7‿Q13‿{𝕩.GetGenSorted}
  "unique"‿"1e5 repetitive" BenchFixLen {
    len ⇐ 1e5
    TypeToGen ⇐ {{len(•rand.Range⟜≠⊏⊢)𝕏} 𝕩.GetGenUnique}
    Input ⇐ {
      name ⇐ "Unique values"
      m ← 𝕩.maxrange
      range ⇐ m ⌊ 1e4⊸≤◶⟨E16, 12‿8⊸E23⟩ max ⇐ len⌊m
    }
  }
  "range"‿"1e5 small-range" BenchFixLen {
    types ⇐ ↕3
    len ⇐ 1e5
    TypeToGen ⇐ {
      min ← ¯1 - max ← 𝕩.max
      mr ← 𝕩.maxrange
      {•internal.Squeeze (min + ⌊4÷˜mr-𝕩) + len•rand.Range𝕩˙}
    }
    Input ⇐ {
      name ⇐ "Range"
      range ⇐ max ⌊ { ⍷⌊(↕1+⌈)⌾((𝕩⋆12÷˜⊢)⁼)𝕩 } max ⇐ 𝕩.maxrange
    }
  }
  BenchBool 1e7‿E16
⟩
