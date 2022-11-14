# Self-searching and sorting/grading

⟨basename⇐name, title, fns⟩ ← ⊑•args

ns     ← •Import "../../params/ns_v.bqn"
types  ← •Import "../../params/cputype.bqn"
tbool  ← ⊑(•Import "../../params/numtype.bqn").range
fnobjs ← ⟨fns⟩ •Import "../../params/arith.bqn"

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
BenchLenAll ⇐ { pe‿pd 𝕊 maxlen‿Scale‿typeToGen:
  Bench∘{
    ext  ⇐ ∾pe‿"-"‿𝕩.disp
    desc ⇐ ∾pd‿" "‿𝕩.label
    getGen ← TypeToGen 𝕩
    input ⇐ {
      name ⇐ "Length"
      range ⇐ Scale max ⇐ maxlen
    }
    Measure ⇐ { 𝕊 ⟨fn⟩:
      TimeParams ⇐ { ⟨Fn, GetGen𝕩⟩ }
      timeInit ⇐ 1e5‿1‿1e3
    }
  }¨ types.range
}
BenchFixLen ⇐ { pe‿pd 𝕊 ⟨len,typeToGen,input⟩:
  Bench∘{
    ext  ⇐ ∾pe‿"-"‿𝕩.disp
    desc ⇐ ∾pd‿" "‿𝕩.label
    getGen ← TypeToGen 𝕩
    input ⇐ Input 𝕩
    Measure ⇐ { 𝕊 ⟨fn⟩:
      len ⇐ len
      TimeParams ⇐ { ⟨Fn, GetGen𝕩⟩ }
    }
  }¨ 𝕩 {⟨i⇐types⟩𝕊𝕩:i⊏𝕩;𝕩} types.range
}
BenchBool ⇐ Bench∘{ maxlen‿Scale:
  ext  ⇐ "bool"
  desc ⇐ "random booleans"
  ⟨GetGen⟩ ← tbool
  input ⇐ {
    name ⇐ "Length"
    range ⇐ Scale max ⇐ maxlen
  }
  Measure ⇐ { 𝕊 ⟨fn⟩:
    TimeParams ⇐ { ⟨Fn, GetGen𝕩⟩ }
    timeInit ⇐ 1e6‿20‿1e4
  }
}
