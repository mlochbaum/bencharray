# / with boolean argument

⟨RandBool⟩ ← •Import "../measure/gen.bqn"

name ⇐ "where"

params ⇐ ⟨⟩

input ⇐ {
  name ⇐ "Size"
  max ⇐ 1e7
  range ⇐ (•Import"../measure/scale.bqn").E13 max
}

result ⇐ {
  name ⇐ "Time (ns / value)"
  max ⇐ 10
  Calc ⇐ {𝕨𝕊x‿y: 1↓¨x⋈1e9×y÷x}
}

measure ⇐ {
  TimeParams ⇐ { ⟨/, RandBool∘𝕩⟩ }
  timeInit ⇐ 1e5‿1‿1e3
}

PlotPre ⇐ ⊢
plotOpts ⇐ {
  title ⇐ "Indices from uniform boolean list"
  x ⇐ input
  y ⇐ result
  labels ⇐ ⋈"/"
  ChangeBounds ⇐ x.max‿y.max⊸⌊
}
