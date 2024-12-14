⍝ input ← 'example.txt'
input ← 'input.txt'
data ← ⍎¨⎕SH'rg -NU "(Button A: X\+)|(, Y\+)|(\nButton B: X\+)|(\nPrize: X=)|(, Y=)" -r " " ', input

per_line ← {
	ax ay bx by gx gy ← ⍵
	a←(gx-(bx÷by)×gy)÷(ax-(bx÷by)×ay)
	b←(gx-(ax÷ay)×gy)÷(bx-(ax÷ay)×by)
	(a=⌈a)×(b=⌈b)×b+a×3
}

]DISPLAY part1 ← +/(per_line)¨data
