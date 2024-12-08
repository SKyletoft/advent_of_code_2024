⍝ file ← 'example.txt'
file ← 'input.txt'

⍝ Shell commands for parsing is totally not cheating, also ChatGPT
⍝ wrote the awk, I don't speak awk
section1 ← ↓⎕CSV('\W+'⎕R','⊢(⎕SH 'awk "NF == 0 { exit } { print }" ', file))''2
section2 ← ⍎¨⎕SH 'awk "found { print } NF == 0 { found=1 }" ', file, ' | sed "s/,/ /g"'

is_ok ← {
	l ← ⍵
	∨/section1∊{l[⍵]}¨↑,/{(⍵,⊂)¨⍳⍵}¨⍳⍴⍵
}
part1 ← +/∊{⍵[⌈(⍴⍵)÷2]×~is_ok⍵}¨section2

part2 ← {
	⍵
}

]DISPLAY part1
⍝ ]DISPLAY part2
