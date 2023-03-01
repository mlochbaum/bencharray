#! /usr/bin/env bqn

# Format number with 3 sig figs and scientific notation
Fmt ⇐ {
  e ← ⌊•math.Log10𝕩
  r ← 0.5+𝕩×10⋆2-e
  {r≥1e3? r÷↩10 ⋄ e+↩1 ; @}
  (1(↑∾"."∾↓)•Repr⌊r)∾"e"∾•Repr e
}

Spl ← (⊢-˜¬×+`)⊸⊔          # Split by boolean left argument
Trim ← ((∨`∧∨`⌾⌽)' '⊸≠)⊸/  # Trim leading and trailing spaces

# Alert if the first function is at least 20% slower than the second
CompareTime ← { fnsc 𝕊 arg:
  fns‿chk ← 2(↑⋈↓)•BQN¨fnsc
  Bad ← ≥⟜(1.2⊸×)´
  GetApply ← {m𝕊⟨w,x⟩: {𝕨 w⊸𝕏_m x}; m𝕊⟨x⟩: {𝕨 𝕏_m x}}⟜arg
  On ← (GetApply {{𝔽}})¨
  Time ← (GetApply •timed)¨⟜fns
  ∧´ On chk ?
  "Non-matching result!" ! ≡´ On fns
  Bad t←Time 1 ? Bad tt←Time 3⌈⌈0.03÷t ?
  # Failed!
  Vs ← ∾⟜" vs "⊸∾
  •Out ((Vs○Trim´2↑fnsc)∾" on "∾arg.desc) ∾ ": " ∾ Vs○Fmt´ t
  ; @
}

RunGroup ← {
  args‿equivs ← 2↑('%'≠⊑¨)⊸⊔ 𝕩
  ('%'⊸=⊸Spl¨ equivs) CompareTime⌜ ∾ (⥊∘•BQN 1⊸↓)¨ args
}

files‿opts ← 2 ↑ ('-'=⊑)¨⊸⊔ •args
files ↩ (0<≠)◶⟨1,∨´"all"⊸≡¨⟩◶⟨∾⟜".bqn"¨, •file.List∘"reductions"⟩ files

lines ← ∾ (⟨""⟩ ∾˜ · (0<≠)◶1‿('#'≠⊑)¨⊸/ · •file.Lines "reductions/"⊸∾)¨ files
groups ← (0=≠¨)⊸Spl lines
•Out 1↓∾' '⊸∾¨ ⟨"Running",•Repr≠groups,"groups:"⟩∾¯4↓¨files
RunGroup¨ groups
