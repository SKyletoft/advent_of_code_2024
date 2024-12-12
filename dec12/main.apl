⍝ data ← ↑⊃ ⎕NGET 'example.txt'1
⍝ data ← ↑⊃ ⎕NGET 'example2.txt'1
data ← ↑⊃ ⎕NGET 'input.txt'1

ac      ← {↑0,¨¯1↓¨↓⍵}
borders ← {(ac⍵) (⌽ac⌽⍵) (⍉ac⍉⍵) (⍉⌽ac⌽⍉⍵)}
c2m     ← {⍺⍴(((2⌷⍵+⊃⍺×(⍵-1))-1)/0),1,(×/⍺)/0}

split ← {
	map        ← ⍵
	candidates ← {{(⍴map) c2m ⍵}¨(∊⍵)/↑,/↓⍳⍴⍵}map
	expand     ← {map∧⍵∨↑∨/borders⍵}
	∪(expand⍣(+/∊map))¨candidates
}

types   ← ∪∊data
regions ←↑,/{split⍵=data}¨types
area    ← {+/∊⍵}¨regions
fences  ← {d←⍵⋄+/∊{d≠⍵∧d≠0}¨borders d}¨regions

]DISPLAY +/×⌿↑area fences
