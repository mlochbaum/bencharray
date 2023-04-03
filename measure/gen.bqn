# Random number generation
⟨Range,Deal⟩ ← •MakeRand ⊑ 6554 ⊣´ •args

Rand ⇐ •internal.Squeeze Range
RandBool ⇐ {𝕩 ↑ 16‿1 •bit._cast (⌈𝕩÷16) Range 2⋆16}

RandUnique ⇐ •internal.Squeeze Deal
