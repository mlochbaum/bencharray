# Self-searching and sorting/grading

⟨basename⇐name, title, fns⟩ ← ⊑•args

scales ← •Import "../../measure/scale.bqn"
ns     ← •Import "../../params/ns_v.bqn"
types  ⇐ •Import "../../params/cputype.bqn"
fnobjs ← ⟨fns⟩ •Import "../../params/arith.bqn"

Scale ← {
  name ⇐ "Length"
  range ⇐ 1 ↓ scales.E13 max ⇐ 𝕩
}

Bench ⇐ {
  ext‿desc‿GetGen ← 𝕩
  plotname ⇐ ∾title‿" "‿desc
  name ⇐ basename∾"-"∾ext
  params ⇐ ⟨fnobjs⟩
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
