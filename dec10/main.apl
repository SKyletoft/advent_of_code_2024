⍝ data ← ↑⍎¨⎕SH'sed "s/[[:digit:]]/\\0 /g" example.txt'
⍝ data ← ↑⍎¨⎕SH'sed "s/[[:digit:]]/\\0 /g" example2.txt'
⍝ data ← ↑⍎¨⎕SH'sed "s/[[:digit:]]/\\0 /g" example3.txt'
data ← ↑⍎¨⎕SH'sed "s/[[:digit:]]/\\0 /g" input.txt'

ac   ← {((⊃⍴⍵)/0),↑¯1↓¨↓⍵}
c2m  ← {⍺{⍺⍴((⍵-1)/0),1,((×/⍺)-⍵)/0}(2⌷⍵)+(⊃⍺×(⊃⍵)-1)}

⍝ Part 1 uses ∨ and ∧ while part 2 uses + and ×:

part1 ← {
	data ← ⍵
	blur ← {↑∨/(ac⍵) (⌽ac⌽⍵) (⍉ac⍉⍵) (⍉⌽ac⌽⍉⍵)}
	find ← {{⍺∧blur⍵}/({⍵=data}¨⌽⍳9),⊂⍵}
	+/{+/∊find (⍴data) c2m ⍵}¨(∊0=data)/(↑,/↓⍳⍴data)
}

part2 ← {
	data ← ⍵
	blur ← {↑+/(ac⍵) (⌽ac⌽⍵) (⍉ac⍉⍵) (⍉⌽ac⌽⍉⍵)}
	find ← {{⍺×blur⍵}/({⍵=data}¨⌽⍳9),⊂⍵}
	+/{+/∊find (⍴data) c2m ⍵}¨(∊0=data)/(↑,/↓⍳⍴data)
}

]DISPLAY part1 data
]DISPLAY part2 data
