# Language definitions for cross-language benchmarks
# - name
# - extension: script is ./avgtime.{extension}
# - shell: command to run a file
# - FmtFn: convert BQN function to source in that language
⟨
  {
    shell ⇐ ⋈ extension⇐name ⇐ "bqn"
    FmtFn ⇐ •Repr⊢
  }
  {
    name ⇐ "j"
    extension ⇐ "ijs"
    shell ⇐ "j9"‿"-c"  # ⟨"jconsole"⟩
    FmtFn ⇐ ("I."‿"{"⊏˜/‿⊏⊸⊐)⌾<∘⊢
  }
  {
    extension⇐name ⇐ "dyalog"
    shell ⇐ ⟨"dyalogscript"⟩
    FmtFn ⇐ ("⍸"‿"⌷⍨∘⊂⍨"⊏˜/‿⊏⊸⊐)⌾<∘⊢
  }
⟩
