#!/usr/bin/env dyalogscript

⍝ input ← ↑⍎¨⎕SH'sed "s/[[:digit:]]/\\0 /g" example.txt'
⍝ input ← ↑⍎¨⎕SH'sed "s/[[:digit:]]/\\0 /g" example2.txt'
⍝ input ← ↑⍎¨⎕SH'sed "s/[[:digit:]]/\\0 /g" example3.txt'
input ← ↑⍎¨⎕SH'sed "s/[[:digit:]]/\\0 /g" input.txt'

ac    ← {↑0,¨¯1↓¨↓⍵}
c2m   ← {⍺⍴(((2⌷⍵+⊃⍺×(⍵-1))-1)/0),1,(×/⍺)/0}
blur  ← {↑+/(ac⍵) (⌽ac⌽⍵) (⍉ac⍉⍵) (⍉⌽ac⌽⍉⍵)}
find  ← {{⍺×blur⍵}/({⍵=input}¨⌽⍳9),⊂⍵}
paths ← ∊{find (⍴input) c2m ⍵}¨(∊0=input)/(↑,/↓⍳⍴input)

⎕← part1 ← +/0≠paths
⎕← part2 ← +/paths
