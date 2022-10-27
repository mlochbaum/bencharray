#! /usr/bin/env bqn

types ← "measure"‿"plot"‿"all"‿"list"‿"help"
type ← ⊑ types ⊐ 1↑•args

Exit ← •Exit∘⊣⟜•Out
⟨At⟩ ← •file

ifHelp‿ifList ← type=1‿2-˜≠types
{¬ifHelp?@;
  0 Exit "Usage: benchmark.bqn (help|list|measure|plot|all) [langs,benchmarks...]"
}

{ifList? 1=≠•args?
  c ← -≠ ext ← ".bqn"
  0 Exit "Available groups:"∾∾(@+10)∾¨ c↓¨ (ext≡c⊸↑)¨⊸/ ∧ •file.List "functions"
;@}

{1<≠•args?@; 1 Exit "No benchmarks specified" }

lnames ← {𝕩.name}¨ langs ← •Import "measure/cross/langs.bqn"
fspec‿lang ← (∊⟜lnames∾2˙)⊸⊔ 1↓•args

fname‿fid ← (⍷⋈⊐) (∧`'-'⊸≠)⊸/¨ fspec
fpath ← ("functions"At∾⟜".bqn")¨ fname

ErrUnknown ← { 1 Exit ∾ ⟨"Unknown ", 𝕨∾"s"/˜1<≠𝕩⟩ ∾ ": "⌾⊑ ⥊(<", ")≍˘𝕩 }

("group" ErrUnknown /⟜fname)⍟(∨´) ¬ •file.Exists¨ fpath

FilterFns ← {
  i ← 𝕨 ⊐˜ n ← {𝕩.name}¨𝕩
  ("benchmark" ErrUnknown /⟜𝕨)⍟(∨´) i=≠𝕩
  i ⊏ 𝕩
}
fns ← ∾ (fid⊔fspec) FilterFns⍟(⊑'-'∊∾∘⊣)⟜(⥊•Import)¨ fpath

{ ¬ifList?@; 0 Exit "Available benchmarks:"∾∾(@+10)∾¨{𝕩.name}¨fns }

⟨LinePlot⇐Plot⟩ ← •Import "plot/line.bqn"

Run ← { 𝕊 lang:
  ⟨TimeFn⟩ ← {
    lang≡@ ? •Import "measure/time.bqn" ;
    ⟨lang⟩ •Import "measure/cross/run.bqn"
  }
  file ← { lang≡@ ? At ; At⟜(∾⟜("-x-"∾lang.name)) }
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
    p ← 𝕨.plotOpts LinePlot 𝕨{⟨P⇐PlotPre⟩_𝕣:P; ⊢} 𝕩
    (("output/plot" File 𝕨.name)∾".svg") •file.Chars p
  }

  TName ← { "output/timings" File 𝕩.name }
  Write ← TName ⊸ •file.Chars ⟜ •Repr
  Read  ← •BQN •file.Chars∘TName

  (type⊑⟨ Write⟜Measure, Plot⟜Read, (Plot⊣Write)⟜Measure ⟩)¨ fns
}
Run¨ ⟨@⟩⊸∾⍟(0=≠) langs ⊏˜ lnames ⊐ lang
