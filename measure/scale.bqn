# Length and other scales

# Shorten last f points to t
Stretch ← ⊢⊘{=´𝕨?𝕩; f‿t𝕊𝕩: i←(↕t)(+-⊢´∘⊣)⌾÷f-1 ⋄ f -⊸(↓∾i+⊑) 𝕩}
GenE ← {𝕊 e‿i‿l: { 𝕩<i ? 1+↕𝕩 ; (1↓↕i)∾⌊(𝕨Stretch·↕1+⌈)⌾((e⋆l+⊢)⁼)𝕩 } }
e105⇐ GenE 1.0503‿35‿73  # Tweak to hit 64
e13 ⇐ GenE 1.3 ‿9‿9
e16 ⇐ GenE 1.63‿5‿4
e23 ⇐ GenE 2.3 ‿4‿2
Q13 ⇐ {9(⌈⋈⊣)⌊13-˜0.66×1.3⋆⁼𝕩}⊸E13  # Stretch last factor of 1000 at 𝕩=1e7

_exp2d ⇐ {(⊢∾𝕩⌈∘÷⌽) ⍷ ⌈ 𝕩 ⋆ (2⊸×÷˜0∾0.5+↕) ⌈2÷˜ ⌈𝕗⋆⁼𝕩}
E2d11 ⇐ 1.115 _exp2d
