⍝ data ← ⊃⎕NGET'input.txt'1
data ← ⊃ ⎕NGET 'input.txt'1
input ← ⍎¨data

per_line ← {{ (∧/⍵∊¯1 ¯2 ¯3)∨(∧/⍵∊1 2 3) } ((⍴⍵)-1)↑⍵-1⌽⍵}

part1 ← {+/per_line¨⍵}
part2 ← {
	withouts←{
		l←⍵
		({l{(⍵↑⍺),((⍵+1)↓⍺)}⍵}¨(⍳⍴l)-1),⊂l
	}
	+/(∨/ (per_line ¨ withouts)) ¨ input
}

]DISPLAY part1 input
]DISPLAY part2 input
