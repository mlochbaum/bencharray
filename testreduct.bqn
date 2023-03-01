#! /usr/bin/env bqn

Spl ← (⊢-˜¬×+`)⊸⊔          # Split by boolean left argument
Trim ← ((∨`∧∨`⌾⌽)' '⊸≠)⊸/  # Trim leading and trailing spaces

opts ← {
help_pre ← 1↓"
Strength reduction tester: compare runtime of equivalent expressions.
Argument is a list of input files and options. Options:"

  short‿long‿args‿dup‿desc ← <˘⍉> ⟨
    "h"‿"help"     ‿0‿1‿"Print this message and exit"
    "t"‿"threshold"‿1‿0‿"Minimum relative performance difference for output (1.2)"
  ⟩
  short‿long ∾˜¨⟜<¨↩ "-"‿"--"
  args ∾↩ 0

  c ← ≠short
  op ← (short⊸⊐ ⌊ long⊸⊐) •args
  op ⌈↩ c ×¬ <`⊸= op⊏args
  opts ← ((1+c)∾˜f/op) ⊔ ((op=c)(1-˜×⟜(+`))○(∾⟜1)f←¬0»op⊏args) ⊔ •args
  "Option can't be duplicated" ! ∧´ (dup∾1) ≥ 1<≠¨opts
  os ← (0⌾⊑dup∾0) (∾','⊸Spl¨)⍟⊣¨ (1⌾(¯1⊸⊑)args) ⊣◶⟨0<≠∘⊢,⊑¨⊢⟩¨ opts
  help‿threshold‿files ⇐ os
  threshold ↩ 1.2 ⊣´ •ParseFloat¨ threshold

  { help ?
    opt_help ← ∾¨´ ⟨desc⟩ ∾˜ (1+·⌈´≠¨)⊸(↑¨)¨ short‿long ∾¨¨ ",:"
    •Out ∾∾⟜(@+10)¨ ⟨help_pre,""⟩ ∾ opt_help
    •Exit@
  ;@}
}

files ← (0<≠)◶⟨1,∨´"all"⊸≡¨⟩◶⟨∾⟜".bqn"¨, •file.List∘"reductions"⟩ opts.files

# Format number with 3 sig figs and scientific notation
Fmt ⇐ {
  e ← ⌊•math.Log10𝕩
  r ← 0.5+𝕩×10⋆2-e
  {r≥1e3? r÷↩10 ⋄ e+↩1 ; @}
  (1(↑∾"."∾↓)•Repr⌊r)∾"e"∾•Repr e
}

# Alert if the first function is at least 20% slower than the second
CompareTime ← { fnsc 𝕊 arg:
  fns‿chk ← 2(↑⋈↓)•BQN¨fnsc
  Bad ← ≥⟜(opts.threshold⊸×)´
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

# Generate argument from one of several abstract specifiers
MakeArg ← {
  ⟨Post,arg⟩: Post 𝕊 arg
;
  ⟨warg,xarg⟩:
    w‿x⇐ ⋄ ⟨wd⇐desc,w⇐x⟩‿⟨xd⇐desc,x⟩ ← 𝕊¨ warg‿xarg
    GetDesc ← {c←+´∧`=´(𝕨⌊○≠𝕩)↑¨𝕨‿𝕩⋄(c↑𝕨)∾∾⟜" and "⊸∾´c↓¨𝕨‿𝕩}
    desc ⇐ {⟨r⇐desc⟩:r ; wd GetDesc xd} 𝕩
;
  ⟨len,type⟩:
    r ← 2‿100‿1e4‿1e9‿0⊑˜"bool"‿"i8"‿"i16"‿"i32"‿"f64"⊸⊐⌾<type
    x ⇐ len •rand.Range r
    desc ⇐ ∾⟨•Repr len," ",type⟩
;
  ⟨len,range⟩:
    desc⇐∾⟨•Repr len," <",•Repr range⟩
    x⇐len •rand.Range range
;
  𝕩
}

RunGroup ← {
  args‿equivs ← 2↑('%'≠⊑¨)⊸⊔ 𝕩
  (('%'⊸=⊸Spl¨ equivs) CompareTime¨ <∘MakeArg)¨ ∾ (⥊∘•BQN 1⊸↓)¨ args
}

lines ← ∾ (⟨""⟩ ∾˜ · (0<≠)◶1‿('#'≠⊑)¨⊸/ · •file.Lines "reductions/"⊸∾)¨ files
groups ← (0=≠¨)⊸Spl lines
•Out 1↓∾' '⊸∾¨ ⟨"Running",•Repr≠groups,"groups:"⟩∾¯4↓¨files
RunGroup¨ groups
