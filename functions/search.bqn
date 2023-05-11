# Search: two-argument ∊⊐⊒

scales ← •Import "../measure/scale.bqn"
ns     ← •Import "../params/ns_v.bqn"
types  ← •Import "../params/cputype.bqn"
fnobjs ← ⟨∊‿⊐‿⊒⟩ •Import "../params/arith.bqn"

# Inputs
Length ← {
  name ⇐ ∾"Searched-"‿𝕨‿" length"
  range ⇐ scales.E13 max ⇐ 𝕩
}
overlap ← {
  name ⇐ "Overlap fraction"
  range ⇐ ↕⊸∾⊸÷ 20
  log ⇐ 0
}

# Argument generator
# Takes searched-in and searched-for lengths, overlap fraction
ParOverlap ← { type 𝕊 in‿for‿overlap:
  # Use a larger synchronized generator and extract overlapping slices
  tot ← in + (¬overlap) × for ⌊ in÷overlap
  range ← 2⋆type.size
  nu ← range ⌊ ⌈tot  # Number uniques to generate
  is ← in ⌊ range (-⟜(20⌊for) ⌊ ×) (÷2) ⌈ in÷tot
  fs ← (is÷overlap) ⌊ (nu-is) ÷ ¬overlap
  fo ← nu - fs
  {𝕏∘(type.GetGenUnique nu)}¨ ⟨
    {is=in ? in⊸↑ ; (⌊ is ×                 in  •rand.Range 0˙)⊸⊏}
               (⌊ fo + fs × (3÷4) ⌈⌾⊑⍟(∧´>) for •rand.Range 0˙)⊸⊏
  ⟩
}
MakePar ← {fn 𝕊 gs: ⟨Fn⟩ ∾ ⌽⍟(fn≡{∊}) gs}

Bench ← {
  input‿Measure ⇐ ext‿desc‿type ← 𝕩
  name     ⇐ ∾"search-"   ‿ext ‿"-"‿type.disp
  plotname ⇐ ∾1↓⥊ (<type.label) ≍˘ '%'((⊢-˜+`×¬)∘=⊔⊢)desc
  params ⇐ ⟨fnobjs⟩
  result ⇐ ns
  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    key ⇐ ⊑params
  }
}

Bench¨ ∾ {𝕏¨types.range}¨ ⟨
  {
    ext ⇐ "rand"
    desc ⇐ "Searching for 1e6 random %s"
    ⟨GetGen⟩ ← type ⇐ 𝕩
    input ⇐ "in" Length 1e4
    Measure ⇐ { 𝕊 ⟨fn⟩:
      len ⇐ 1e6
      TimeParams ⇐ { fn MakePar ⟨GetGen 𝕩, (𝕩+1) GetGen len⟩ }
    }
  }
  {
    ext ⇐ "half"
    desc ⇐ "Searching for 1e6 %s, half hits"
    type ⇐ 𝕩
    input ⇐ "in" Length 1e4
    Measure ⇐ { 𝕊 ⟨fn⟩:
      len ⇐ 1e6
      TimeParams ⇐ { fn MakePar type ParOverlap 𝕩‿len‿0.5 }
    }
  }
  {
    ext ⇐ "total"
    desc ⇐ "Searching with 1e6 total %s, half hits"
    type ⇐ 𝕩
    input ⇐ {
      name ⇐ {∾"Searched-"‿𝕩‿" length"}¨ "in"‿"for"
      max ⇐ 10⋆e←6 ⋄ Comp ← ⊢∾max-1↓⌽
      range ⇐ Comp scales.E23⊸⌊ max÷2
      Trans ⇐ (1-˜max⊸×)⌾÷ ⋄ ticks ⇐ Comp (10⋆↕e)∾max÷2
    }
    Measure ⇐ { 𝕊 ⟨fn⟩:
      len ⇐ 1e6
      TimeParams ⇐ { fn MakePar type ParOverlap 𝕩‿(len-𝕩)‿0.5 }
    }
  }
  {
    ext ⇐ "overlap"
    desc ⇐ "Searching for 1e6 %s in 1e3"
    type ⇐ 𝕩
    input ⇐ overlap
    Measure ⇐ { 𝕊 ⟨fn⟩:
      len ⇐ 1e6
      TimeParams ⇐ { fn MakePar type ParOverlap 1e3‿len‿𝕩 }
    }
  }
⟩
