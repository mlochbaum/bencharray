# Sorting and grading

BenchLenAll‿BenchBool ← "common/self.bqn" •Import˜ {
  name ⇐ "sort"
  title ⇐ "Sorting"
  fns ⇐ ∧‿∨‿⍋‿⍒
}

E13‿E23 ← •Import "../measure/scale.bqn"

∾ ⟨
  "rand"‿"random" BenchLenAll 1e7‿E13‿{𝕩.GetGen}
  BenchBool 1e7‿E23
⟩
