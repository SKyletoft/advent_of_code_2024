⍝ file ← 'example.txt'⋄size←11 7
file ← 'input.txt'⋄size←101 103
⍝ This can't be inlined because dyalog inserts encoding errors before each ¯
⎕SH'sh format-input.sh ',file
input ← ⍎¨⊃⎕NGET 'formatted.txt'1

c2m ← {w h←⍺⋄y x←⍵⋄⍺⍴(((x+h×(y-1))-1)/0),1,((×/⍺)/0)}
per_robot ← {p v←⍵⋄size|(200×size)+p+⍺×v}

state_at ← {
	m←⍉↑+/{size c2m (1 1)+⍵}¨(⍺ per_robot {2⍴↓1 2 2⍴⍵})¨⍵
	w h←size
	l←⍳(⌊w÷2)
	r←(⍳w)~(⍳(⌈w÷2))
	t←⍳(⌊h÷2)
	b←(⍳h)~(⍳(⌈h÷2))
	×/(+/∊m[t;l]) (+/∊m[t;r]) (+/∊m[b;l]) (+/∊m[b;r])
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
