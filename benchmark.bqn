#! /usr/bin/env bqn

Exit ← •Exit∘⊣⟜•Out
⟨At⟩ ← •file

help ← "help"‿"-h"‿"--help"
ops ← help∾"list"‿"measure"‿"plot"
htype ← ⊑ ops (0<≠∘⊢)◶⟨≠∘⊣, ⊐⟜⊏⟩ •args

{(≠help)≤htype?@;
  0 Exit 1↓"
Usage: benchmark.bqn [list|measure|plot] [langs,benchmarks...]

Default (no argument): measure and plot
list:    display benchmark names only
measure: perform benchmarks, storing timings in output/timings
plot:    plot benchmarks, storing svg plots in output/plot"
}

lnames ← {𝕩.name}¨ langs ← •Import "measure/cross/langs.bqn"
fspec‿lang ← (∊⟜lnames∾2˙)⊸⊔ (htype<≠ops) ↓ •args

type ← htype - 1+≠help
ifList ← ¯1 = type
ifMeasure ← ⊑ type ∊ 0‿2

# If no groups are given, use them all
{0<≠fspec?@;
  c ← -≠ ext ← ".bqn"
  fspec ↩ c↓¨ (ext≡c⊸↑)¨⊸/ ∧ •file.List "functions"
  {ifList ? 0 Exit "Available groups:"∾∾(@+10)∾¨fspec ; @}
  •Out⍟ifMeasure "Measuring all benchmarks. This will take several minutes."
}

fname‿fid ← (⍷⋈⊐) (∧`'-'⊸≠)⊸/¨ fspec
fpath ← ("functions"At∾⟜".bqn")¨ fname

ErrUnknown ← { 1 Exit ∾ ⟨"Unknown ", 𝕨∾"s"/˜1<≠𝕩⟩ ∾ ": "⌾⊑ ⥊(<", ")≍˘𝕩 }

("group" ErrUnknown /⟜fname)⍟(∨´) ¬ •file.Exists¨ fpath

FilterFns ← ∧⊸{
  i ← 1 -˜ 𝕨 ⍋ n ← {𝕩.name}¨𝕩
  f ← (i⊏𝕨) (⊣≡≠⊸↑)¨ n
  ("benchmark" ErrUnknown /⟜𝕨)⍟(∨´) 0=(≠𝕨)↑/⁼f/i
  f / 𝕩
}
fns ← (fid⊔fspec) FilterFns⍟(⊑'-'∊∾∘⊣)⟜(⥊•Import)¨ fpath

{ ¬ifList?@; 0 Exit "Selected benchmarks:"∾∾(@+10)∾¨{𝕩.name}¨∾fns }

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

  do ← type⊑⟨ Write⟜Measure, Plot⟜Read, (Plot⊣Write)⟜Measure ⟩
  Start ← (•Out"Starting "∾⊢)⍟(ifMeasure∧15≤+´≠¨fns)
  fname {Start𝕨 ⋄ Do¨𝕩}¨ fns
}
Run¨ ⟨@⟩⊸∾⍟(0=≠) langs ⊏˜ lnames ⊐ lang
