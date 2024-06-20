# Boolean synonyms, ∧×⌊ and ∨⌈

% {warg‿xarg⇐𝕩}¨ 0‿1 (⋈¨∾⋈¨˜) {len⇐1e4,type⇐"bool"}
% {warg‿xarg⇐𝕩}¨ ⋈⟜⌽ {len⇐𝕩,type⇐"bool"}¨ ⟨1e3‿10,1e3⟩
× % ∧
⌊ % ∧
⌈ % ∨

% {warg‿xarg⇐𝕩}¨ 0‿1 (⋈⌜∾⋈˜⌜∾⋈⌜˜∘⊢) {len⇐𝕩,type⇐"bool"}¨⟨10,100,50‿2⟩
×⌜ % ∧⌜
*F←{×⌊} % F⌜ % ∧⌜

% {warg‿xarg⇐𝕩}¨ ⋈⟜⌽ {len⇐𝕩,type⇐"bool"}¨ ⟨1e3‿10,10⟩
×⎉1 % ∧⎉1
*F←{×⌊} % F⎉1 % ∧⎉1

% {len⇐1e4,type⇐"bool"}
*_m←{´˝`}         % ⌈_m % ∨_m
*_m←{´˝`} *F←{×⌊} % F _m % ∧_m

% {len⇐𝕩,type⇐"bool"}¨ ⋈¨⟜⌽10⋆0‿1‿3‿4
*_m←{˝ ` {𝔽`˘} {𝔽´˘}}         % ⌈_m % ∨_m
*_m←{˝ ` {𝔽`˘} {𝔽´˘}} *F←{×⌊} % F _m % ∧_m
