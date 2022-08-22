# Self-search: one-argument ⊐⊒∊

basename ← "selfsearch"
tname ← "Self-search"

scales ← •Import "../measure/scale.bqn"
ns     ← •Import "../params/ns_v.bqn"
types  ← •Import "../params/cputype.bqn"
fns    ← ⟨⊐‿⊒‿∊⟩ •Import "../params/arith.bqn"

Scale ← {
  name ⇐ "Length"
  range ⇐ 1 ↓ scales.E13 max ⇐ 𝕩
}

Bench ← {
  ext‿desc‿GetGen ← 𝕩
  plotname ⇐ ∾tname‿" of "‿desc
  name ⇐ basename∾"-"∾ext
  params ⇐ ⟨fns⟩
  input ⇐ Scale 1e7
  result ⇐ ns
  Measure ⇐ { 𝕊 ⟨fn⟩:
    TimeParams ⇐ { ⟨Fn, GetGen𝕩⟩ }
    timeInit ⇐ 1e5‿1‿1e3
  }
  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    ⟨labels⟩ ⇐ ⊑params
  }
}

Bench¨ ∾ ⟨
  {
    ext  ⇐ "rand-"  ∾𝕩.disp
    desc ⇐ "random "∾𝕩.label
    ⟨GetGen⟩ ⇐ 𝕩
  }¨ types.range
  {
    ext  ⇐ "sort-"  ∾𝕩.disp
    desc ⇐ "sorted "∾𝕩.label
    GetGen ⇐ {∧𝕏} 𝕩.GetGen
  }¨ types.range
⟩

