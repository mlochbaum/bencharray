# Random number generation
⟨Range,Deal,Subset⟩ ← •MakeRand ⊑ 6554 ⊣´ •args
⟨Squeeze⟩ ← •internal

Rand ⇐ Squeeze Range
RandBool ⇐ {𝕩 ↑ 16‿1 •bit._cast (⌈𝕩÷16) Range 2⋆16}

RandUnique ⇐ Squeeze Deal
RandUniqueSort ⇐ Squeeze Subset
# All results equally likely: ∧∘Rand makes runs rarer
RandSort ⇐ ∧∘Squeeze · -⟜(↕≠) ⊣ Subset +-1˙

# 𝕨 positive (not zero) integers summing to 𝕩
Partition ⇐ ¯1 (⊢-») (Subset∾⊢)○(-⟜1)
