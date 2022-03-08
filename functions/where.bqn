# / with boolean argument

⟨RandBool⟩ ← •Import "../measure/gen.bqn"

name ⇐ "where"

xmax ← 1e7
measure ⇐ ⋈{
  TimeParams ⇐ { ⟨/, RandBool∘𝕩⟩ }
  timeInit ⇐ 1e5‿1‿1e3
  xmax ⇐ xmax
}

plotOpts ⇐ {
  title ⇐ "Indices from uniform boolean list"
  xcapt ⇐ "Size"
  ycapt ⇐ "Time (ns / value)"
  labels ⇐ ⋈"/"
  ChangeBounds ⇐ xmax‿10⊸⌊
}
