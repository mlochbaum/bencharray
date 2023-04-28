# Number parsing
Nat  ← 10⊸×⊸+˜´∘⌽ -⟜'0'
Nats ← {(>⟜«0≤𝕩)/0(0⊸≤××⟜10⊸+)`𝕩}∘-⟜'0'

meta ← •file.Lines "/tmp/bencharray_meta"
fn‿valence‿iter‿arrs ← •BQN‿Nat‿Nat ((⊣{𝕎𝕩}¨≠⊸↑) ∾⟜< ≠⊸↓) meta

data ← •file.Bytes "/tmp/bencharray_data"
Get ← {
  qual ← ⊑𝕩
  width‿shape ← (⊑ ⋈ 1⊸↓) Nats 1↓𝕩
  size ← ⌈ (width ÷ 8) ×´ shape
  d ← size ↑ data
  data ↓˜↩ size
  shape ⥊ ⟨8‿'c',width‿qual⟩ •bit._cast d
}
args ← Get¨ arrs

dy ← 2 = valence
timed ← dy ⊑ {𝔽•_timed}‿{𝔽´•_timed}
•Show iter ((0⊣Fn)¨ _timed - ⊢¨ _timed) {<˘⍉∘‿2⥊𝕩}⍟dy args
