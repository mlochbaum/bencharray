⎕IO ⎕ML ← 0 1
meta ← (⎕UCS 10) (≠⊆⊢) ⊃ ⎕NGET '/tmp/bencharray_meta'
(fn valence iter arrs) ← 3 ((1(↑,⍎¨⍤↓)↑) , ⊂⍤↓) meta

data ← {(⎕NUNTIE ⍵)⊢⎕NREAD ⍵ 83 ¯1} 0 ⎕NTIE⍨ '/tmp/bencharray_data'
get ← {
  qual ← ⊃⍵
  (width shape) ← (⊃ ,⍥⊂ 1∘↓) ⍎ 1↓⍵
  size ← ⌈ (width ÷ 8) × ×⌿ shape
  d ← size ↑ data
  data ↓⍨← size
  conv ← ((10×width)+1+2×'uif'⍳qual) ⎕DR ⊃0 83⎕DR d
  shape ⍴ (⌽size 8⍴⊢)⍣(1=width)⊢ conv
}
args ← get¨ arrs

dy ← 2 = valence
(aa aw) ← {~dy: ⍬⍵ ⋄ ↓⍉(2÷⍨≢⍵)2⍴⍵} args
(noop expr) ← ('{⍬⊣',,∘'}¨⍳iter')∘('aa ',⍣dy,∘'¨ aw')¨ '⊢'fn
10 ⎕DT 'J'  ⍝ Unpredictable delays otherwise
t0 ← 10 ⎕DT 'J'
⍎ noop
t1 ← 10 ⎕DT 'J'
⍎ expr
t2 ← 10 ⎕DT 'J'
⎕ ← (iter×1e9) ÷⍨ (t2-t1)-(t1-t0)
