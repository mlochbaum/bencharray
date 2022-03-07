# / with boolean argument

⟨RandBool⟩ ← •Import "../measure/gen.bqn"

name ⇐ "where"

TimeParams ⇐ { ⟨/, RandBool∘𝕩⟩ }
timeInit ⇐ 1e5‿1‿1e3
xmax ⇐ 1e7

plotOpts ⇐ {
  title ⇐ "Indices from uniform boolean list"
  xcapt ⇐ "Size"
  ycapt ⇐ "Time (ns / value)"
  labels ⇐ ⋈"BQN"
  ChangeBounds ⇐ xmax‿10⊸⌊
}
