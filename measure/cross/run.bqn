# Write files and run the measurement function

# Adapted from _timedGen in measure/time.bqn
a0 ← 4                            # Number of wanted argument sets
_estCount ← {
  t ← 𝕨 𝔽○{𝕏@} 𝕩                  # Start with one timing
  n ← 1+⌊(1+1e¯1÷t)÷2             # Target 0.1 for one run, 0.05 for many
  n<50 ?
    n‿(n ⌊ a0 ⌈ ⌊5÷n)
  ;
    t ← (+´÷≠)𝕨𝔽¨○{𝕏¨↕10}𝕩        # Redo the timing with more runs
    a ← a0 + ⌊2e¯5÷t              # Try to add sets
    r ← ⌈(200⌊2e¯2÷t)÷a           # Number of reps
    r‿a
}

typ ← {
  Get ← •internal.Eltype
  fmt ← ∾⟜•Fmt´¨ bit ← "uiiif" ⋈¨ 2⋆0∾3+↕4
  Write ⇐ fmt⊑˜Get
  Conv ⇐ {w←⌽bit⊑˜Get𝕩 ⋄ ⟨w,8‿'c'⟩ •bit._cast ∾⟜(0⥊˜8|-∘≠)⍟(1=⊑w) 𝕩}
}

TimeFn ⇐ {
  iter‿num ← {
    fn‿x  :   fn    •_timed   _estCount x ;
    fn‿w‿x: w fn{𝕨⊸𝔽•_timed𝕩} _estCount x
  } 𝕩
  arrs ← ⥊⍉> {𝕏¨↕num}¨ 1↓𝕩
  header ← (typ.Write∾·∾' '∾¨•Fmt¨∘≢)¨ arrs
  meta ← ⟨"I."⟩∾(•Fmt¨⟨1-˜≠𝕩,iter⟩)∾header  # Hard-coded / → I.
  "/tmp/bencharray_meta" •file.Lines meta
  "/tmp/bencharray_data" •file.Bytes ∾ typ.Conv∘⥊¨ arrs
  res ← 1 ⊑ •SH "j9"‿"-c"‿(•file.At"avgtime.ijs")
  num ÷˜ 0 ⌈ •BQN "_¯" (⊢+-˜´∘⊣×⊑⊸=) res
}
