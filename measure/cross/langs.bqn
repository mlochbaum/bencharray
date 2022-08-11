# Language definitions for cross-language benchmarks
# - name
# - extension: script is ./avgtime.{extension}
# - shell: command to run a file
# - FmtFn: convert BQN function to source in that language

fns‿fnd‿fnj ← (⊑¨<⊸∾·{<˘⍉>>𝕩}((2⥊⋈⍟(1≥≡))¨·(2⌊∘÷˜≠)⊸(-⊸↓⋈↓)·⊑⍟(1=≠)1↓⊢)¨) ⟨
  +‿"+", ×‿"×*", ⋆‿"*^"
  -‿"-", ÷‿"÷%", √‿"*∘(÷2)"‿"*∘÷⍨"‿"%:"‿"%:"
  ⌊‿"⌊"‿"<.",    |‿"|"
  ⌈‿"⌈"‿">.",    ¬‿"1+-"‿"~"‿"1+-"‿"-."
  ∧‿"{(⊂⍋⍵)⌷⍵}"‿"∧"‿"/:~"‿"*."
  ∨‿"{(⊂⍒⍵)⌷⍵}"‿"∧"‿"/:~"‿"*."
  <‿"⊂"‿"<"‿"<"‿"<", ≤‿"≤"‿"<:"
  >‿"↑"‿">"‿">"‿">", ≥‿"≥"‿">:"
  ≠‿"≢"‿"≠"‿"#"‿"~:"
  =‿"≢∘⍴"‿"="‿"#@$"‿"="
  ≡‿"≡"‿("L:"‿"-:")
  ≢‿"⍴"‿"≢"‿"$"‿"-.@-:"
  ⊣‿"⊣["
  ⊢‿"⊢]"
  ⥊‿","‿"⍴"‿","‿"$"
  ∾‿"(⊃,/)"‿"⍪"‿";"‿"," # Lists only for monadic
  ↑‿"↑"‿"{."  # Assume dyadic
  ↓‿"↓"‿"}."  # Assume dyadic
  ⌽‿"⌽"‿"|."
  ⍉‿"⍉"‿"|:"  # J dyadic doesn't work
  /‿"⍸"‿"⌿"‿"I."‿"#"
  ⍋‿"⍋"‿"⍸"‿"/:"‿"I."
  ⍒‿"⍒"‿"" ‿"\:"‿""
  ⊏‿"⊣⌿"‿"⌷⍨∘⊂⍨"‿"{."‿"{"
  ⊐‿"(∪⍳⊢)"‿"⍳"‿"(i.~~.)"‿"i."
  ∊‿"≠"‿"∊"‿"~:"‿"e."
  ⍷‿"∪"‿"⍷"‿"~."‿"E."
  # Not covered: ≍⋈↕«»⊑⊒⊔!
⟩

_fmtLang_ ← {
  t‿d ← (⊑⋈1⊸↓) •Decompose 𝕩
  P←"("∾∾⟜")" ⋄ F ← 𝕨𝕊⊢ ⋄ Tr ← P·∾F¨
  t◶⟨
    𝕗 ⊑˜ (𝕨-1)⋈·⊑fns⊸⊐  # 0 primitive
    !, Tr, Tr           # 1 block, 2/3 train
    𝔾{!{⌜}≡1⊑𝕩⋄𝔽 F⊑𝕩}   # 4 1-modifier
    !                   # 5 2-modifier
  ⟩ d
}

⟨
  {
    shell ⇐ ⋈ extension⇐name ⇐ "bqn"
    FmtFn ⇐ •Repr⊢
  }
  {
    name ⇐ "j"
    extension ⇐ "ijs"
    shell ⇐ "j9"‿"-c"  # ⟨"jconsole"⟩
    FmtFn ⇐ fnj _fmtLang_ (∾⟜"/")
  }
  {
    extension⇐name ⇐ "dyalog"
    shell ⇐ ⟨"dyalogscript","MAXWS=2G"⟩
    FmtFn ⇐ fnd _fmtLang_ ("∘."∾("("∾∾⟜")")⍟(1<≠))
  }
⟩