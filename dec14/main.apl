⍝ file ← 'example.txt'⋄size←11 7
file ← 'input.txt'⋄size←101 103
⍝ This can't be inlined because dyalog inserts encoding errors before each ¯
⎕SH'sh format-input.sh ',file
input ← ⍎¨⊃⎕NGET 'formatted.txt'1

c2m ← {w h←⍺⋄y x←⍵⋄⍺⍴(((x+h×(y-1))-1)/0),1,((×/⍺)/0)}
per_robot ← {x y dx dy←⍵⋄size|(x y)+⍺×(dx dy)}

state_at ← {
	m←↑+/{size c2m (1 1)+⍵}¨(⍺per_robot⊣)¨⍵
	w h←size
	l←⍳(⌊w÷2)
	r←(⍳w)~(⍳(⌈w÷2))
	t←⍳(⌊h÷2)
	b←(⍳h)~(⍳(⌈h÷2))
	×/(+/∊m[l;t]) (+/∊m[r;t]) (+/∊m[l;b]) (+/∊m[r;b])
}

part1 ← {100 state_at ⍵}

part2 ← {
	data ← ⍵
	all_states ← {(⍵ state_at data)}¨⍳11000
	minimum ← ⌊/all_states
	ok←all_states≤minimum
	⊃ok/⍳⊃⍴ok
}

]DISPLAY part1 input
]DISPLAY part2 input
