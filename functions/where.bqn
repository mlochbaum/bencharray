# / with boolean argument

⟨RandBool⟩ ← •Import "../measure/gen.bqn"

name ⇐ "where"

params ⇐ ⟨⟩
result ⇐ ⟨10⟩ •Import "../params/ns_v.bqn"

input ⇐ {
  name ⇐ "Size"
  max ⇐ 1e7
  range ⇐ 1 ↓ (•Import"../measure/scale.bqn").E13 max
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
