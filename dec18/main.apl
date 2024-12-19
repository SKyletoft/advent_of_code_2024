⍝ input ← ⍎¨⎕SH'sed "s/,/ /g" example.txt'⋄size←7 7⋄fallen←12
input ← ⍎¨⎕SH'sed "s/,/ /g" input.txt'⋄size←71 71⋄fallen←1024

w h ← size

c2m  ← {x y←⍵ ⋄ (1@(1+x+h×y))((×/size)/0)}
ac   ← {↑0,¨¯1↓¨↓⍵}
blur ← {↑∨/(ac⍵) (⌽ac⌽⍵) (⍉ac⍉⍵) (⍉⌽ac⌽⍉⍵)}

start ← size⍴size c2m (0 0)
end   ← size⍴size c2m (size - 1 1)

step ← {
	current visited ←⍵
	next ← {⍵+0≠⍵}(0=visited)∧⍺∧blur⊢current
	next (next∨visited)
}

search ← {
	map ← ~⊃∨/{size⍴size c2m ⍵}¨⍺↑⍵
	size⌷⊃2⌷{map step ⍵}⍣{(⍺≡⍵)∨0≠size⌷⊃2⌷⍵} (start start)
}

predicate ← {0≠⍺search⍵}

bs ← {
	⎕IO←0
	(⍺+1)≥⍵:⍵
	mid ← ⌊(⍺+⍵)÷2
	p ← mid predicate input
	a ← p⌷⍺ mid
	w ← p⌷mid ⍵
	a∇w
}

part1 ← {(fallen search ⍵)-1} input
part2 ← ⊃(1 bs (⊃⍴input))⌷input

]DISPLAY part1
]DISPLAY part2
