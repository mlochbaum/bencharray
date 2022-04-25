# Arithmetic primitives
name ⇐ "Primitive"
default ← ×‿+‿-‿⌊‿⌈
range ⇐ default ⊣´ •args
num ⇐ ↕≠range
log ⇐ 0
labels ⇐ •Repr¨ range
Disp ⇐ ⊑⟜labels
