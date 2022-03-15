#! /usr/bin/env bqn

types ← "measure"‿"plot"‿"all"‿"list"‿"help"
type ← ⊑ types ⊐ 1↑•args

Exit ← •Exit∘⊣⟜•Out
⟨At⟩ ← •file

{type<1-˜≠types?@;
  0 Exit "Usage: benchmark.bqn (help|list|measure|plot|all) [functions...]"
}

{type≠2-˜≠types?@; # List
  c ← -≠ ext ← ".bqn"
  0 Exit "Available functions:"∾∾(@+10)∾¨ c↓¨ (ext≡c⊸↑)¨⊸/ •file.List "functions"
}

{1<≠•args?@; 1 Exit "No functions specified" }

fpath ← ("functions"At∾⟜".bqn")¨ fnames ← 1↓•args

fexist ← 1∘•file.Type⎊0¨ fpath
{0=≠𝕩?@; 1 Exit ∾"Unknown functions: "⌾⊑⥊(<", ")≍˘𝕩 } fexist¬⊸/fnames

fns ← ∾ ⥊∘•Import¨ fpath

⟨TimeFn⟩ ← •Import "measure/time.bqn"
⟨LinePlot⇐Plot⟩ ← •Import "plot/line.bqn"

Measure ← {
  params‿input‿result‿Measure ← 𝕩
  M ← {
    Time ← TimeFn 𝕩.TimeParams
    {⟨i⇐timeInit⟩:Time¨i;@} 𝕩
    𝕩 result.Calc ⋈⟜(Time¨) input.Range 𝕩
  }
  > M∘Measure¨ (<⟨⟩) <⊸∾⌜´ {𝕩.range}¨ params
}
Plot ← {
  p ← 𝕨.plotOpts LinePlot 𝕨.PlotPre 𝕩
  ("output/plot"At𝕨.name∾".svg") •file.Chars p
}

TName ← { "output/timings" At 𝕩.name }
Write ← TName ⊸ •file.Chars ⟜ •Repr
Read  ← •BQN •file.Chars∘TName

(type⊑⟨ Write⟜Measure, Plot⟜Read, (Plot⊣Write)⟜Measure ⟩)¨ fns
