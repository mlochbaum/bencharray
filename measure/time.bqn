# Utilities for estimated timings

# Methods here attempt to remove noise that adds time to measurements,
# for example switching to other processes. This also removes amortized
# costs such as garbage collection, so it's not entirely suitable for
# cross-language comparisons.

# Since noise almost always increases rather than decreases execution
# time, it's removed by taking a minimum or other selection that skews
# low from timings. This is only ever applied to measurements on the
# same set of arguments, to avoid ignoring sets that are actually slower
# to evaluate. It's also not done if most measurements are below 0.5μs,
# because at this scale the timer's resolution may be relevant and cause
# bias with filtering. Multiple sets of arguments are always generated
# if more than one run is used, and calls cycle through the generated
# sets to avoid branch prediction.

# Estimated average time to run 𝔽 in 𝕨 𝔽¨ 𝕩 when 𝔽 is quick
# Time for 𝔽 is assumed deterministic but can vary based on argument
# Calls 𝔽 at least 200 times, and at least 9 on each argument
# For best reliability, an individual call of 𝔽 should take >5μs
# Seems accurate within 2% or so
_avgTime_ ← {
  n ← ≠⥊𝕨⊢¨𝕩                      # Number of calls (𝕘 reps each)
  Mid ← (⌈𝕘÷2)↑(⌊´0‿2+⌊𝕘÷3‿10)↓∧  # Reject potential outliers
  Fil ← Mid˘ ⊣⍟(∧´5e¯7≤⊏˘∘⊣) ⊢    # Unless times are too low
  FT ← (+´÷≠)∘⥊ ·Fil∘⍉ 𝔽¨         # And average
  t ← 𝕨 FT{𝔽𝕏;𝕎𝔽𝕏}○({𝕩˙}𝕘‿n⊸⥊) 𝕩  # Bind argument arrays
  Cond ← {
    4>≠𝕩?1;                       # Always take at least 4 samples
    20≤≠𝕩?0;                      # And give up at 20
    ¬∧´(⊢≤1.01×⌊´)¯3↑𝕩            # Stop if samples are within 1%
  }
  ⌊´ ∾⟜T •_while_ Cond ↕0         # Run to completion; take minimum
}

# Estimated time to run function given argument generators
# Tries to limit total time used, so if one run takes a while and can
# differ based on generator output then the result will be inconsistent
# Quick calls are pooled to reject outliers; for slower ones this is
# less likely to work so we just average
a0 ← 4                            # Number of wanted argument sets
_timedGen ← {
  s ← •MonoTime@
  t ← 1e¯8⌈ 𝕨 𝔽○{𝕏@} 𝕩            # Start with one timing (also warmup)
  s ↩ t⌈3÷˜(•MonoTime@)-s         # In case 𝔽 is much faster than 𝕎/𝕏
  n‿m ← 1+⌊(1+1e¯1÷t‿s)÷2         # Target 0.1 for one run, 0.05 for many
  m<50 ?
    a ← n ⌊ a0 ⌈ ⌊5÷m             # ≤5 reps unless m<n, and no unused args
    t ↩ 𝕨𝔽¨○{n⥊𝕏¨↕a}𝕩             # Repeat args to get rep number up
    Z ← 0⊸</⍟(∨´⊣)⊢               # Some systems might occasionally get 0
    (+´÷≠) ⌊´∘Z¨ (a|↕∘≠)⊸⊔ t      # Min across equal args, then average
  ;
    i ← 𝕨⋈○{𝕏¨↕10}𝕩               # More inputs
    t ← 1e¯8⌈ (+´÷≠)𝕨𝔽¨∘⊑⊘(𝔽¨´⊢)i # Redo the timing
    e ← (2⋆12) ÷ +´((+´÷≠)≠∘⥊¨)¨i # Cap total elements for added sets
    a ← a0 + ⌊e⌊2e¯5÷t            # Try to add sets
    r ← ⌈(200⌊2e¯2÷t)÷a           # Number of reps
    𝕨 𝔽_avgTime_ r○{𝕏¨↕a} 𝕩       # Do the fancy timing
}
TimeFn ⇐ {
  fn‿x  :   fn    •_timed   _timedGen x ;
  fn‿w‿x: w fn{𝕨⊸𝔽•_timed𝕩} _timedGen x
}
