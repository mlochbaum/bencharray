# Sorting and grading

types‿Bench ← "common/self.bqn" •Import˜ {
  name ⇐ "sort"
  title ⇐ "Sorting"
  fns ⇐ ∧‿∨‿⍋‿⍒
}

Bench¨ ∾ ⟨
  {
    ext  ⇐ "rand-"  ∾𝕩.disp
    desc ⇐ "random "∾𝕩.label
    ⟨GetGen⟩ ⇐ 𝕩
  }¨ types.range
⟩
