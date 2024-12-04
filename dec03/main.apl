input ← ⊃⎕NGET'input.txt'1
⍝ input ← ⊃ ⎕NGET 'example.txt'1

part1 ← {+/{×/⍎¨('\d+'⎕S'\u0')⍵}¨('mul\(\d+,\d+\)'⎕S'\u0')⍵}

⍝ ]DISPLAY part1 input

⍝ regex ← ' (mul\(\d+,\d+\))
⍝	 | don't()
⍝	 | do()
⍝	 '
⍝ regex ← '(mul\(\d+,\d+\))|don\x27t\(\)|do\(\)'

test     ← 1 0 0 1 0 ¯1 ¯1 0 1 ¯1
expected ← 1 1 1 1 1  0  0 0 1  0
⍝ regex ← 'don\x27t\(\)' 'mul\(\d+,\d+\)' 'do\(\)'
⍝ matchtype←1,{⍵-1}(regex⎕S{⍵.PatternNum}) input
⍝ ]DISPLAY matchtype
clamp←{1⌊0⌈⍵}
clampadd ← {clamp (⍺ + ⍵)}
⍝ clampadd\1 ¯1 0 1

⍝ ]DISPLAY ⊖clampadd\
]DISPLAY ⊖(1,test)

⍝ ]DISPLAY {clamp (⍺+⍵)}⍀matchtype
⍝ ]DISPLAY +⍀matchtype
⍝ ⍝ ]DISPLAY enabled←1↓+\1,{⍵-1}(regex⎕S{⍵.PatternNum}) input

⍝ clamp←{1⌊0⌈⍵}
⍝ ]DISPLAY enabled←1↓({1⌊0⌈⍵}+)\matchtype
⍝ ⍝ {('\d+'⎕S'\u0')⍵}
⍝ matches ←(regex⎕S{⍵.Match}) input
⍝ digits←{('\d+'⎕S'\u0')⍵}¨matches
⍝ mask←,0≠⍉↑(⍴¨)digits
⍝ ⍝ (enabled ∧ mask)/digits
⍝ ⍝ ]DISPLAY {×/⍎¨⍵}¨(enabled ∧ mask)/digits
