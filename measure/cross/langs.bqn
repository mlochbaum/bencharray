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
mds‿mdv‿mdd‿mdj‿mda ← <˘ {∾⟜𝕏}⍟(3>•Type)¨⌾(2↑2⊸↓) ⍉ >∾⟜1⍟(5>≠)¨ ⟨
  ˘‿0‿"⍤¯1"‿"""_1"
  ¨‿0‿"¨"‿"&.>"
  ⌜‿0‿("∘."∾("("∾∾⟜")")⍟(1<≠))‿"/"
  ⁼‿0‿("⍟"⊣"*"⁼)‿("^."‿"I.^:_1"⊑˜"^"‿"I."⊸⊐⌾<)
  ´‿2‿"/"‿"/"
  ˝‿2‿"⌿"‿"/"
  `‿2‿"⍀"‿"/\"‿(∊⟜⌈‿⌊‿+‿×‿∧‿∨‿=‿≠⌾<)
⟩

_fmtLang_ ← {
  t‿d ← (⊑⋈1⊸↓) •Decompose 𝕩
  P←"("∾∾⟜")" ⋄ F ← 𝕨𝕊⊢ ⋄ Tr ← P·∾F¨
  t◶⟨
    𝕗 ⊑˜ (𝕨-1)⋈·⊑fns⊸⊐    # 0 primitive
    !, Tr, Tr             # 1 block, 2/3 train
    mds⊸⊐⌾<⊸(⊑⟜𝕘{𝕎𝕩}(𝕨⊣⍟(≠⟜0)˜⊑⟜mdv)⊸𝕊⊣⊑⟜mda⊸{!𝕎𝕩})˜´ # 4 1-modifier
    !                     # 5 2-modifier
  ⟩ d
}

"extendlangs.bqn" •Import˜⍟(•file.Exists⊣) ⟨
  {
    shell ⇐ ⋈ extension⇐name ⇐ "bqn"
    FmtFn ⇐ •Repr⊢
  }
  {
    name ⇐ "j"
    extension ⇐ "ijs"
    shell ⇐ "j9"‿"-c"  # ⟨"jconsole"⟩
    FmtFn ⇐ fnj _fmtLang_ mdj
  }
  {
    extension⇐name ⇐ "dyalog"
    shell ⇐ ⟨"dyalogscript","MAXWS=2G"⟩
    FmtFn ⇐ fnd _fmtLang_ mdd
  }
⟩
