# Arithmetic functions

⟨Rand⟩ ← •Import "../measure/gen.bqn"

name ⇐ "arith"

arith ← +‿-‿×

xmax ← 2e6
measure ⇐ {
  TimeParams ⇐ { ⟨+, 𝕩 Rand 16˙, 𝕩 Rand 16˙⟩ }
  timeInit ⇐ 1e5‿1‿1e3
  xmax ⇐ xmax
}¨ arith

plotOpts ⇐ {
  title ⇐ "Arithmetic on 1-byte values, no overflow"
  xcapt ⇐ "Size"
  ycapt ⇐ "Time (ns / value)"
  labels ⇐ •Repr¨ arith
  ChangeBounds ⇐ xmax‿10⊸⌊
}
