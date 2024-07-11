# Insert ˝ and Scan ` on rank-2 arrays
⟨basename⇐name, _op⟩ ← ⊑•args

oname ← •Repr op

⟨RandBool⟩ ← •Import "../../measure/gen.bqn"
cputypes   ← •Import "../../params/cputype.bqn"
bench2d    ← {basename⇐basename} •Import "bench2d.bqn"

BoolDat ← { ext 𝕊 fns:
  ext⇐ ⋄ fname ⇐ "F" ⋄ arg ⇐ "boolean"
  params ⇐ ⟨⟨fns⟩ •Import "../../params/logic.bqn"⟩
  GetTime ⇐ { mod 𝕊 ⟨fn⟩: { ⟨Fn _mod, RandBool∘𝕩⟩ } }
}

ArithDat ← { ext 𝕊 fn:
  ext⇐ ⋄ fname ⇐ •Repr fn ⋄ arg ⇐ "numeric"
  params ⇐ ⟨cputypes⟩
  GetTime ⇐ { mod 𝕊 ⟨type⟩: { ⟨Fn _mod, type.GetGen𝕩⟩ } }
}

mods ← ⟨
  ""      ‿  _op  ‿ oname
  "-cells"‿{𝔽_op˘}‿(oname∾"˘")
⟩
mods Bench2d⌜ ⟨
  "boolean" BoolDat ∧‿∨‿=‿≠‿+‿-
  "boolcmp" BoolDat <‿>‿≤‿≥
  "plus" ArithDat {+}
  "min"  ArithDat {⌊}
⟩
