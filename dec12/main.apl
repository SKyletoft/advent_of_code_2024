#!/usr/bin/env dyalogscript

⍝ data ← ↑⊃ ⎕NGET 'example.txt'1
⍝ data ← ↑⊃ ⎕NGET 'example2.txt'1
data ← ↑⊃ ⎕NGET 'input.txt'1

ac      ← {↑0,¨¯1↓¨↓⍵}
borders ← {(ac⍵) (⌽ac⌽⍵) (⍉ac⍉⍵) (⍉⌽ac⌽⍉⍵)}
c2m     ← {⍺⍴(((2⌷⍵+⊃⍺×(⍵-1))-1)/0),1,(×/⍺)/0}

split_ ← {
	⍺=0:⍬
	map    ← ⍵
	expand ← {map∧⍵∨↑∨/borders⍵}
	new    ← (expand⍣≡){{(⍴map) c2m ⍵}⊃(∊⍵)/↑,/↓⍳⍴⍵}map
	(⊂new),((⍺-+/∊new)∇(⍵∧~new))
}
split ← {(+/∊⍵)split_⍵}

regions      ← ↑,/{split⍵=data}¨∪∊data
area         ← {+/∊⍵}¨regions
fences       ← {d←⍵⋄{d≠⍵∧d≠0}¨borders d}¨regions
long_fences  ← (+/∊)¨fences
short_fences ← ∊⍴¨↑(,/(split¨))¨fences

⎕←part1 ← +/×⌿↑ area long_fences
⎕←part2 ← +/×⌿↑ area short_fences
