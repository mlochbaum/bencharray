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

apply ← (2=valence) ⊑ {𝔽}‿{𝔽˝ ·⍉∘‿2⊸⥊}
•Show (Fn¨•_timed - ⊢¨•_timed)_apply args
