⎕IO ⎕ML ← 0 1
meta ← (⎕UCS 10) (≠⊆⊢) ⊃ ⎕NGET '/tmp/bencharray_meta'
(fn valence iter arrs) ← 3 ((1(↑,⍎¨⍤↓)↑) , ⊂⍤↓) meta

data ← ⊃ (⍳256) ⎕NGET '/tmp/bencharray_data'
get ← {
  qual ← ⊃⍵
  (width shape) ← (⊃ ,⍥⊂ 1∘↓) ⍎ 1↓⍵
  size ← ⌈ (width ÷ 8) × ×⌿ shape
  d ← size ↑ data
  data ↓⍨← size
  shape ⍴ (⌽size 8⍴⊢)⍣(1=width)⊢ ((10×width)+1+2×'uif'⍳qual) ⎕DR d
}
args ← get¨ arrs

dy ← 2 = valence
(aa aw) ← {~dy: ⍬⍵ ⋄ ↓⍉(2÷⍨≢⍵)2⍴⍵} args
(noop expr) ← ('{⍬⊣',,∘'}¨⍳iter')∘('aa ',⍣dy,∘'¨ aw')¨ '{⍬}'fn
t0 ← 1⊃⎕AI
⍎ noop
t1 ← 1⊃⎕AI
⍎ expr
t2 ← 1⊃⎕AI
⎕ ← (iter×1e3) ÷⍨ (t2-t1)-(t1-t0)
