# Utilities for estimated timings

_bind ← {𝔽𝕏;𝕎𝔽𝕏}

# Estimated average time to run 𝔽 in 𝕨 𝔽¨ 𝕩 when 𝔽 is quick
# Time for 𝔽 is assumed deterministic but can vary based on argument
# Calls 𝔽 at least 200 times, and at least 9 on each argument
# For best reliability, an individual call of 𝔽 should take >5μs
# Seems accurate within 2% or so
_avgTime_ ⇐ {
  n ← ≠⥊𝕨⊢¨𝕩                      # Number of calls (𝕘 reps each)
  Mid ← (⌈𝕘÷2)↑(⌊´0‿2+⌊𝕘÷3‿10)↓∧  # Reject potential outliers
  FT ← (+´÷≠)∘⥊ ·Mid˘∘⍉ 𝔽¨        # And average
  t ← 𝕨 FT _bind○({𝕩˙}𝕘‿n⊸⥊) 𝕩    # Bind argument arrays
  Cond ← {
    4>≠𝕩?1;                       # Always take at least 5 samples
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
TimeFn ⇐ {
  _sub ← { # Function and arguments are 𝕨𝔽𝕩 here
    t ← 5e¯9⌈𝕨 𝔽○{𝕏@} 𝕩           # Start with one timing (also warmup)
    a ← 4                         # Number of wanted argument sets
    n ← 1+⌊(1+1e¯1÷t)÷2           # Target 0.1 for one run, 0.05 for many
    𝕨𝔽{
      n<50 ?
        a ⌊↩ n                    # Don't make args that won't be used
        t ← 𝕨𝔽¨○{n⥊𝕏¨↕a}𝕩         # Repeat args to get rep number up
        (+´÷≠) ⌊´¨ (a|↕∘≠)⊸⊔ t    # Min across equal args, then average
      ;
        a +↩ ⌊2e¯5÷t              # Try to add sets
        r ← ⌈(200⌊n)÷a            # Number of reps
        𝕨 𝔽_avgTime_ r○{𝕏¨↕a} 𝕩   # Do the fancy timing
    }𝕩
  }
  {fn‿x: fn•_timed _sub x; fn‿w‿x: w fn{𝕨⊸𝔽•_timed𝕩} _sub x} 𝕩
}
