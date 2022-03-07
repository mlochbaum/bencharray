# / with boolean argument

⟨TimeFn⟩   ← •Import "../measure/time.bqn"
⟨RandBool⟩ ← •Import "../measure/gen.bqn"
scale      ← •Import "../measure/scale.bqn"

Time ← { TimeFn ⟨/, RandBool∘𝕩⟩ }
Time¨ 1e5‿1‿1e3
y ← 1e9×x÷˜ Time¨ x ← scale.E13 1e7
•Out (•Import "../plot/line.bqn").Plot 1↓¨x⋈y
