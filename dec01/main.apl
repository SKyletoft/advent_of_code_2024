data ← ⊃ ⎕NGET 'input.txt'1
⍝ data ← ⊃ ⎕NGET 'example.txt'1
input ← ⎕CSV('\W+'⎕R','⊢data)''2

part1 ← {
        l←{⍵[⍋⍵]}⍵[;1]
        r←{⍵[⍋⍵]}⍵[;2]
        +/| (l - r)
}

part2 ← {
        l←⍵[;1]
        r←⍵[;2]
        +/{⍵×+/⍵=r}¨l
}

]DISPLAY part1 input
]DISPLAY part2 input

⎕OFF
