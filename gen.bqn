# Random number generation
seed ← 6554 ⊣´ •args
Range ← {𝕨 (•MakeRand seed).Range 𝕩}

Rand ⇐ •internal.Squeeze Range
RandBool ⇐ {𝕩 ↑ 16‿1 •bit._cast (⌈𝕩÷16) Range 2⋆16}
