# Sorting and grading

types‿BenchLenAll ← "common/self.bqn" •Import˜ {
  name ⇐ "sort"
  title ⇐ "Sorting"
  fns ⇐ ∧‿∨‿⍋‿⍒
}

∾ ⟨
  "rand"‿"random" BenchLenAll 1e7‿{𝕩.GetGen}
⟩
