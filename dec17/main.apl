input← ⊃⎕NGET'example.txt'1
⍝ input← ⊃⎕NGET'input.txt'1

a←⍎12↓⊃1⌷input
b←⍎12↓⊃2⌷input
c←⍎12↓⊃3⌷input
program←{l←9↓⊃5⌷⍵⋄⍎(' '@((l=',')/⍳⍴l))l}input
out ← ⍬
]DISPLAY state ← a b c 1 out program

⍝ Register A: 729
⍝ Register B: 0
⍝ Register C: 0

⍝ Program: 0,1,5,4,3,0

program ← 0 1 5 4 3 0
a ← 729
b ← 0
c ← 0

⍝ State: [a, b, c, pc, out, program]

step ← {
	a b c pc out program ← state
	⎕←pc (⍴program) (pc≥⍴program)
	pc≥⍴program : ⍵ ⋄
	a b c (pc + 1) out program
}

a b c pc out program ← state
]DISPLAY (step⍣≡)state
