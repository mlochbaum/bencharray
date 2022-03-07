#! /usr/bin/env bqn

types ← "measure"‿"plot"‿"all"‿"help"
type ← ⊑ types ⊐ 1↑•args

Exit ← •Exit∘⊣⟜•Out
⟨At⟩ ← •file

{type<1-˜≠types?@;
  0 Exit "Usage: benchmark.bqn (help|measure|plot|all) [functions...]"
}

{1<≠•args?@; 1 Exit "No functions specified" }

fns ← •Import∘("functions"At∾⟜".bqn")⎊@¨ fnames ← 1↓•args

{0=≠𝕩?@; 1 Exit ∾"Unknown functions: "⌾⊑⥊(<", ")≍˘𝕩 } (fns≡¨@)/fnames

⟨TimeFn⟩ ← •Import "measure/time.bqn"
scale    ← •Import "measure/scale.bqn"
⟨LinePlot⇐Plot⟩ ← •Import "plot/line.bqn"

All ← {
  Time ⇐ TimeFn 𝕩.TimeParams
  Time¨ 𝕩.timeInit

  y ← 1e9×x÷˜ Time¨ x ← scale.E13 𝕩.xmax
  ("output/plot"At𝕩.name∾".svg") •file.Chars 𝕩.plotOpts LinePlot 1↓¨x⋈y
}
Measure ← Plot ← !

(type⊑Measure‿Plot‿All)¨ fns
