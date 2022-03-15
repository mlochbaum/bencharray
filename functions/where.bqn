# / with boolean argument

⟨RandBool⟩ ← •Import "../measure/gen.bqn"

name ⇐ "where"

params ⇐ ⟨⟩

xmax ← 1e7
measure ⇐ {
  TimeParams ⇐ { ⟨/, RandBool∘𝕩⟩ }
  timeInit ⇐ 1e5‿1‿1e3
  scale ⇐ (•Import"../measure/scale.bqn").E13 xmax
  Result ⇐ {x𝕊y: 1↓¨x⋈1e9×y÷x}
}

PlotPre ⇐ ⊢
plotOpts ⇐ {
  title ⇐ "Indices from uniform boolean list"
  x ⇐ {name⇐"Size"}
  y ⇐ {name⇐"Time (ns / value)"}
  labels ⇐ ⋈"/"
  ChangeBounds ⇐ xmax‿10⊸⌊
}
