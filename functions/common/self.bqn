# Self-searching and sorting/grading

⟨basename⇐name, title, fns⟩ ← ⊑•args

scales ← •Import "../../measure/scale.bqn"
ns     ← •Import "../../params/ns_v.bqn"
types  ⇐ •Import "../../params/cputype.bqn"
fnobjs ← ⟨fns⟩ •Import "../../params/arith.bqn"

Scale ← {
  name ⇐ "Length"
  range ⇐ scales.E13 max ⇐ 𝕩
}

Bench ⇐ {
  input‿Measure ⇐ ext‿desc ← 𝕩
  plotname ⇐ ∾title‿" "‿desc
  name ⇐ basename∾"-"∾ext
  params ⇐ ⟨fnobjs⟩
  result ⇐ ns
  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    ⟨labels⟩ ⇐ ⊑params
  }
}
BenchLenAll ⇐ { pe‿pd 𝕊 maxlen‿typeToGen:
  Bench∘{
    ext  ⇐ ∾pe‿"-"‿𝕩.disp
    desc ⇐ ∾pd‿" "‿𝕩.label
    getGen ← TypeToGen 𝕩
    input ⇐ Scale maxlen
    Measure ⇐ { 𝕊 ⟨fn⟩:
      TimeParams ⇐ { ⟨Fn, GetGen𝕩⟩ }
      timeInit ⇐ 1e5‿1‿1e3
    }
  }¨ types.range
}
BenchFixLen ⇐ { pe‿pd 𝕊 ⟨len,typeToGen,input,timeInit⟩:
  Bench∘{
    ext  ⇐ ∾pe‿"-"‿𝕩.disp
    desc ⇐ ∾pd‿" "‿𝕩.label
    getGen ← TypeToGen 𝕩
    input ⇐ input
    Measure ⇐ { 𝕊 ⟨fn⟩:
      len ⇐ len
      TimeParams ⇐ { ⟨Fn, GetGen𝕩⟩ }
    }
  }¨ types.range
}
