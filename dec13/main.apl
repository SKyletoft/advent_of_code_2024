input ← 'example.txt'
⍝ input ← 'input.txt'
data ← ↑⍎¨⎕SH'rg -NU "(Button A: X\+)|(, Y\+)|(\nButton B: X\+)|(\nPrize: X=)|(, Y=)" -r " " ', input

]DISPLAY data
