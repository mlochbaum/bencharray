# Multi-axis operations on a single axis, or equivalent

% {warg⇐⟨2⟩⋄xarg⇐𝕩}¨ ⟨1e3,10‿1e3,1e3‿3⟩ {len⇐𝕨⋄type⇐𝕩}⌜ "bool"‿"i8"‿"i16"‿"i32"‿"f64"
*F←{↑↓↕⌽} % F % ⊑⊸F

% ∾⥊ {𝕊x:{warg⇐⟨𝕩⟩⋄xarg⇐x}¨↕≠x.len}¨ ⟨1e3,10‿1e3,4‿5‿6‿5‿4‿3⟩ {len⇐𝕨⋄type⇐𝕩}⌜ "bool"‿"i8"‿"i32"
*T←{⍉ ⍉⁼} % T % ⊑⊸T
*T←{⍉ ⍉⁼} % T % T⊢ % ⊑⊸=⟜(1-˜=)

% (⟨↕0,1,1e3,7‿3‿5⟩ {w𝕊l:{𝕊t:warg⇐{Post⇐{desc⇐"⋈ of "∾𝕩.desc,x⇐⟨𝕩.x⟩}⋄arg⇐{len⇐w⋄range⇐⊑l}}⋄xarg⇐{len⇐l⋄type⇐t}}}⌜ ⟨100,20‿5⟩) {𝕎𝕩}⌜ "bool"‿"i8"‿"i16"‿"i32"‿"f64"
⊏ % ⊑⊸⊏

% ⟨100,1e4⟩ {l𝕊t:warg⇐{Post⇐{desc⇐"⋈ of "∾𝕩.desc,x⇐⟨𝕩.x⟩}⋄arg⇐{len⇐l⋄range⇐4}}⋄xarg⇐{len⇐l⋄type⇐t}}⌜ "bool"‿"i8"‿"i16"‿"i32"‿"f64"
/ % ⊑⊸/
⊔ % ⊑⊸⊔

% ⟨↕0,30‿20‿10⟩ {l𝕊t:warg⇐{len⇐l⋄range⇐10}⋄xarg⇐{len⇐l⋄type⇐t}}⌜ "bool"‿"i8"‿"i16"‿"i32"‿"f64"
⊔ % ⊔○⥊
