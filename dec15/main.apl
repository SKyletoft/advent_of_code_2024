map   ← '########' '#..O.O.#' '##..O..#' '#...O..#' '#.#.O..#' '#...O..#' '#......#' '########'
moves ← '><v^'⍳'<^^>>>vv<v>>v<<'
pos   ← 3 3

size←⍴↑map
w h ← size

]DISPLAY moves
⍝ ]DISPLAY ↑map

right ← ⊣
left  ← {⌽¨⍵}
down  ← {↓⍉↑⍵}
up    ← {↓⌽⍉↑⍵}
unup  ← {↓⍉⌽↑⍵}

c2m       ← {x y←⍵ ⋄ (1@(1+x+h×y))((×/size)/0)}

rotate ← {⊃⍵⌷(right ⍺) (left ⍺) (down ⍺) (up ⍺)}
restore ← {⊃⍵⌷(right ⍺) (left ⍺) (down ⍺) (unup ⍺)}
rotate_pos ← {
	x y ← ⍺
	⊃⍵⌷⍺ ((1+w-x) y) (y x) (y (1+w-x))
}
restore_pos ← {
	x y ← ⍺
	⊃⍵⌷⍺ ((1+w-x) y) (y x) ((y+1) x)
}

⍝ line ← '#..O.O.#'
⍝ line ← '#..OOO.#'
⍝ line ← '#..O#O.#'
⍝ x ← 3

move_right ← {
	(x y) map ← ⍵
	line ← ⊃y⌷map
	first_wall ← (x↓line)⍳'#'
	first_empty ← (x↓line)⍳'.'
	⎕← first_wall (x+first_empty) (⍴line)
	shifted ← ⊂('.'@(x+1))('O'@(x+first_empty))line
	⎕← first_wall first_empty
	⊃(1+first_empty<first_wall)⌷⍵ (((x+1) y) ((shifted@y)map))
}

move ← {
	⎕ ← ''
	pos map ← ⍺
	pos ← pos rotate_pos ⍵
	map ← map rotate ⍵
	pos map ← move_right (pos map)
	pos ← pos restore_pos ⍵
	map ← map restore ⍵
	pos map
}

x ← (pos map)
]DISPLAY ↑↑x[2]
x ← x move 2
]DISPLAY ↑↑x[2]

x ← 1
line ← '####'

]DISPLAY first_wall ← (x↓line)⍳'#'
]DISPLAY first_empty ← (x↓line)⍳'.'
