# / with boolean argument

⟨TimeFn⟩ ← •Import "time.bqn"
⟨RandBool⟩ ← •Import "gen.bqn"
scale ← •Import "scale.bqn"

Time ← { TimeFn ⟨/, RandBool∘𝕩⟩ }
Time¨ 1e5‿1‿1e3
•Show (1e9×÷˜)`˘ > ⋈⟜Time¨ scale.E13 1e7
