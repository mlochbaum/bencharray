# Insert ˝

⟨RandBool⟩ ← •Import "../measure/gen.bqn"
scales     ← •Import "../measure/scale.bqn"
cputypes   ← •Import "../params/cputype.bqn"
ns←{min⇐0.01}•Import "../params/ns_v.bqn"

Bench2d ← { mext‿mod‿mname 𝕊 dat:
  ⟨params⟩ ⇐ ext‿fname‿arg‿GetTime ← dat
  plotname ⇐ ∾"Insert"‿mext‿" "‿fname‿mname‿" of "‿arg‿" "‿"rank 2 array"
  name     ⇐ ∾"insert"‿mext‿"-2d-"‿ext
  total ← 10⋆e←4
  input ⇐ {
    name ⇐ "Width"
    range ⇐ 1.5 scales._exp2d total
  }
  result ⇐ ns
  Measure ⇐ {
    Flip ← total⌈∘÷⊢  # Length of other dimension
    Len ⇐ Flip⊸×
    TimeParams ⇐ (mod GetTime 𝕩)∘(Flip⊸⋈)
    timeInit ⇐ 1e5‿1‿1e3
  }
  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    ⟨labels⟩ ⇐ ⊑params
  }
}

BoolDat ← { ext 𝕊 fns:
  ext⇐ ⋄ fname ⇐ "F" ⋄ arg ⇐ "boolean"
  params ⇐ ⟨⟨fns⟩ •Import "../params/logic.bqn"⟩
  GetTime ⇐ { mod 𝕊 ⟨fn⟩: { ⟨Fn _mod, RandBool∘𝕩⟩ } }
}

ArithDat ← { ext 𝕊 fn:
  ext⇐ ⋄ fname ⇐ •Repr fn ⋄ arg ⇐ "numeric"
  params ⇐ ⟨cputypes⟩
  GetTime ⇐ { mod 𝕊 ⟨type⟩: { ⟨Fn _mod, type.GetGen𝕩⟩ } }
}

mods ← ⟨
  ""      ‿˝    ‿"˝"
  "-cells"‿{𝔽˝˘}‿"˝˘"
⟩
mods Bench2d⌜ ⟨
  "boolean" BoolDat ∧‿∨‿=‿≠‿+‿-
  "boolcmp" BoolDat <‿>‿≤‿≥
  "plus" ArithDat {+}
  "min"  ArithDat {⌊}
⟩
