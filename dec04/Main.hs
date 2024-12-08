{-# LANGUAGE GHC2021    #-}
{-# LANGUAGE LambdaCase #-}

import           Data.Char       (toLower)
import           Data.List       ((!?))
import           Data.List.Extra (transpose)
import           Data.Maybe      (catMaybes, isJust)

main = interact $ (++ "\n") . show . both part1 part2 . lines

both f g x = (f x, g x)

rotate xs =
  [ xs
  , transpose xs
  , map reverse xs
  , map reverse (transpose xs)
  , diamond xs
  , diamond (transpose xs)
  , diamond . map reverse $ xs
  , diamond . transpose . map reverse $ xs
  ]

diamond xs =
  let diag = length xs + length (head xs) - 2
   in [catMaybes [xs !!? (to - x, x) | x <- [0 .. to]] | to <- [0 .. diag]]

infixl 9 !!?

(!!?) :: [[a]] -> (Int, Int) -> Maybe a
xxs !!? (i, j) = (xxs !? i) >>= (!? j)

findXmas =
  \case
    []                   -> 0
    ('X':'M':'A':'S':xs) -> 1 + findXmas xs
    (_:xs)               -> findXmas xs

isXmas input (i, j) =
  let topLeft     = input !!? (i - 1, j - 1)
      bottomRight = input !!? (i + 1, j + 1)
      topRight    = input !!? (i - 1, j + 1)
      bottomLeft  = input !!? (i + 1, j - 1)
   in input !!? (i, j) == Just 'A'
        && ((topLeft == Just 'M' && bottomRight == Just 'S')
              || (topLeft == Just 'S' && bottomRight == Just 'M'))
        && ((topRight == Just 'S' && bottomLeft == Just 'M')
              || (topRight == Just 'M' && bottomLeft == Just 'S'))

part1 = sum . map (sum . map findXmas) . rotate

part2 input =
  let w = length input
      h = length (head input)
   in length [() | x <- [0 .. w], y <- [0 .. h], isXmas input (x, y)]
