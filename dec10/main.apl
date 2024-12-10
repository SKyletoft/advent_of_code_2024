⍝ data ← ↑⍎¨⎕SH'sed "s/[[:digit:]]/\\0 /g" example.txt'
⍝ data ← ↑⍎¨⎕SH'sed "s/[[:digit:]]/\\0 /g" example2.txt'
data ← ↑⍎¨⎕SH'sed "s/[[:digit:]]/\\0 /g" example3.txt'
⍝ data ← ↑⍎¨⎕SH'sed "s/[[:digit:]]/\\0 /g" input.txt'

ac ← {↑(⊃⍴⍵)↑¨↓((⊃⍴⍵)/0),(⊃⍴⍵)⌽⍵}
b ← {↑∨/(ac⍵) (⌽ac⌽⍵) (⍉ac⍉⍵) (⍉⌽ac⌽⍉⍵)}
find ← {{9=data∧b⍵}{8=data∧b⍵}{7=data∧b⍵}{6=data∧b⍵}{5=data∧b⍵}{4=data∧b⍵}{3=data∧b⍵}{2=data∧b⍵}{1=data∧b⍵}⍵}
c2m ← {
	i←(2⌷⍵)+⊃⍺×((⊃⍵)-1)
	⍺⍴((i-1)/0),1,(((×/⍺)-i)/0)
}

]DISPLAY part1 ← +/{+/∊find (⍴data) c2m ⍵}¨(∊0=data)/(↑,/↓⍳⍴data)
⍝ ]DISPLAY part2 ← {⌈/{+/∊⍵}¨(({9=data∧b⍵}{8=data∧b⍵}{7=data∧b⍵}{6=data∧b⍵}{5=data∧b⍵}{4=data∧b⍵}{3=data∧b⍵}{2=data∧b⍵}{1=data∧b⍵}⍵) ({8=data∧b⍵}{7=data∧b⍵}{6=data∧b⍵}{5=data∧b⍵}{4=data∧b⍵}{3=data∧b⍵}{2=data∧b⍵}{1=data∧b⍵}⍵) ({7=data∧b⍵}{6=data∧b⍵}{5=data∧b⍵}{4=data∧b⍵}{3=data∧b⍵}{2=data∧b⍵}{1=data∧b⍵}⍵) ({6=data∧b⍵}{5=data∧b⍵}{4=data∧b⍵}{3=data∧b⍵}{2=data∧b⍵}{1=data∧b⍵}⍵) ({5=data∧b⍵}{4=data∧b⍵}{3=data∧b⍵}{2=data∧b⍵}{1=data∧b⍵}⍵) ({4=data∧b⍵}{3=data∧b⍵}{2=data∧b⍵}{1=data∧b⍵}⍵) ({3=data∧b⍵}{2=data∧b⍵}{1=data∧b⍵}⍵) ({2=data∧b⍵}{1=data∧b⍵}⍵) ({1=data∧b⍵}⍵))}¨(∊0=data)/(↑,/↓⍳⍴data)
