⍝ data ← ↑⊃ ⎕NGET 'example.txt'1
data ← ↑⊃ ⎕NGET 'example2.txt'1
⍝ data ← ↑⊃ ⎕NGET 'input.txt'1

ac      ← {↑0,¨¯1↓¨↓⍵}
borders ← {(ac⍵) (⌽ac⌽⍵) (⍉ac⍉⍵) (⍉⌽ac⌽⍉⍵)}

⍝ ]DISPLAY types ← ∪∊data
⍝ ]DISPLAY area ← +/∊'A'=data
⍝ ]DISPLAY fences ← {d←⍵⋄+/∊{d≠⍵∧d≠0}¨borders d} 'A'=data
