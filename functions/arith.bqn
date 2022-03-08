# Arithmetic functions

name ⇐ "arith"

arith ← +‿-‿×

xmax ← 2e6
measure ⇐ 127 { max𝕊fn:
  GetGen ← {
    ⟨Rand⟩ ← ⟨𝕩⟩ •Import "../measure/gen.bqn"
    (⌈max÷2) -˜ 𝕩 Rand max˙
  }
  TimeParams ⇐ {
    # Use one generator for both arguments
    ×˙⊸≠fn ? l ← 1‿2/⟨fn, GetGen𝕩⟩ ;
    # For × arguments need to interact to suppress overflow: use two
    # parallel generators but run each twice so each argument sees both
    # sets of random numbers
    ⟨fn⟩ ∾ ⊣‿{(××(⌊max÷|𝕨)⌊|)𝕩} {𝕎○𝕏˜}⟜GetGen¨ <𝕩
  }
  timeInit ⇐ 1e5‿1‿1e3
  xmax ⇐ xmax
}⌜ arith

plotOpts ⇐ {
  title ⇐ "Arithmetic on 1-byte values, no overflow"
  xcapt ⇐ "Size"
  ycapt ⇐ "Time (ns / value)"
  labels ⇐ •Repr¨ arith
  ChangeBounds ⇐ xmax‿10⊸⌊
}
