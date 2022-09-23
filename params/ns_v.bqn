# Nanoseconds per value result type

a ← ⊑⍟(⟨1⟩≡≢) •args
denom ← {⟨r⇐denom⟩:r;"value"} a
name ⇐ ∾"Time (ns / "‿denom‿")"
Calc ⇐ {𝕨𝕊x‿y: x⋈1e9×y÷𝕨{⟨Len⟩_𝕣:Len;⊢}x}
max ⇐ {⟨r⇐max⟩:r;∞} a
