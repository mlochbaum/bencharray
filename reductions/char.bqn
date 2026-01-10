# Character arrays

% 1e3‿1e5 {len⇐𝕨,type⇐𝕩}⌜ "c8"‿"c16"‿"c32"
% ⟨1e4⟩ {n𝕊t:Post⇐{desc⇐"sorted "∾𝕩.desc,x⇐∧𝕩.x}⋄arg⇐{len⇐n⋄type⇐t}}⌜ <"c8"
*F←{⍋⍒∊⊐⊒} % F % F∘(-⟜@)
*F←{∧∨⍷} % F % F⌾(-⟜@)
*F←{⍋⍒∊⊐⊒} % F % F∘•internal.Squeeze∘(-⟜(128+@)) % ∧´(@+256)>⊢
*F←{∧∨⍷} % F % F○•internal.Squeeze⌾(-⟜(128+@)) % ∧´(@+256)>⊢
*F←{⍋⍒∊⊐⊒} % F % F∘•internal.Squeeze∘(-⟜(@+2⋆15)) % <´·∧˝˘(@+2⋆8‿16)>⌜⊢
*F←{∧∨⍷} % F % F○•internal.Squeeze⌾(-⟜(@+2⋆15)) % <´·∧˝˘(@+2⋆8‿16)>⌜⊢

#% {warg⇐𝕨⋄xarg⇐𝕩}⌜˜ 10‿1e4 {len⇐𝕨,type⇐𝕩}⌜ "c8"‿"c16"‿"c32"
% (⋈⌜˜10‿1e4) {m‿n𝕊t:warg‿xarg⇐{len⇐𝕩,type⇐t}¨𝕨}⌜ "c8"‿"c16"‿"c32"
% {warg⇐𝕨⋄xarg⇐𝕩}⌜˜ {len⇐1e3,type⇐𝕩}¨ "c8"‿"c16"‿"c32"
*F←{∊⊐⊒} % F % F○(-⟜@)

% {warg⇐{Post⇐{desc‿x⇐𝕩⋄x∧↩}⋄arg⇐𝕩}𝕨⋄xarg⇐𝕩}⌜˜ {len⇐1e4,type⇐𝕩}¨ "c8"‿"c16"‿"c32"
⍋ % ⍋○(-⟜@)

% {warg⇐{Post⇐{desc‿x⇐𝕩⋄x∨↩}⋄arg⇐𝕩}𝕨⋄xarg⇐𝕩}⌜˜ {len⇐1e4,type⇐𝕩}¨ "c8"‿"c16"‿"c32"
⍒ % ⍒○(-⟜@)

# Non-matching types
% {warg⇐𝕨⋄xarg⇐𝕩}{𝔽⋈𝔽˜}´ 1e4‿1e2 {len⇐𝕨,type⇐𝕩}¨ "c8"‿"i16"
∊ % 0¨⊣
⊐ % ≠⊸(⊣¨)
⊒ % ≠⊸(⊣¨)

% {warg⇐{Post⇐{desc‿x⇐𝕩⋄x∧↩}⋄arg⇐𝕩}𝕨⋄xarg⇐𝕩}{𝔽⋈𝔽˜}´ 1e4‿1e2 {len⇐𝕨,type⇐𝕩}¨ "c8"‿"i16"
⍋ % (≠∘⊣×≤○⊑)⊣¨⊢

% {warg⇐{Post⇐{desc‿x⇐𝕩⋄x∨↩}⋄arg⇐𝕩}𝕨⋄xarg⇐𝕩}{𝔽⋈𝔽˜}´ 1e4‿1e2 {len⇐𝕨,type⇐𝕩}¨ "c8"‿"i16"
⍒ % (≠∘⊣×≥○⊑)⊣¨⊢
