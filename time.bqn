# Utilities for estimated timings

_bind ← {𝔽𝕏;𝕎𝔽𝕏}

# Estimated average time to run 𝔽 in 𝕨 𝔽¨ 𝕩 when 𝔽 is quick
# Time for 𝔽 is assumed deterministic but can vary based on argument
# Calls 𝔽 at least 200 times, and at least 9 on each argument
# For best reliability, an individual call of 𝔽 should take >5μs
# Seems accurate within 2% or so
_avgTime ⇐ {
  r ← 9⌈⌈200÷ n ← ≠⥊𝕨⊢¨𝕩          # Reps; number of calls in each
  Mid ← (⌈r÷2)↑(2+⌊r÷10)↓∧        # Reject potential outliers
  FT ← (+´÷≠)∘⥊ ·Mid˘∘⍉ 𝔽•_timed¨ # And average
  t ← 𝕨 FT _bind○({𝕩˙}r‿n⊸⥊) 𝕩    # Bind argument arrays
  Cond ← {
    5>≠𝕩?1;                       # Always take at least 5 samples
    20≤≠𝕩?0;                      # And give up at 20
    ¬∧´(⊢≤1.01×⌊´)¯4↑𝕩            # Stop if samples are within 1%
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
    run ← 𝕨 𝔽•_timed _bind○{𝕏@} 𝕩 # Time a random run
    t ← Run@                      # Start with one timing
    𝕨𝔽{
      1e¯3≤t ?                    # Took a while: straight average
        n ← ⌊(1+1e¯1÷t)÷2         # Target 0.1 for one run, 0.05 for many
        (+´÷≠) t ∾ Run¨↕n         # Time the extras and average
      ;
        n ← 4+⌊2e¯5÷t             # Number of argument sets
        𝕨 𝔽_avgTime○{𝕏¨↕n} 𝕩      # Do the fancy timing
    }𝕩
  }
  {fn‿x: fn _sub x; fn‿w‿x: w fn _sub x} 𝕩
}
