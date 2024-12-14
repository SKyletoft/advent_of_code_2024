module Main where

import           Data.Char       (isDigit)
import           Data.List.Extra (splitOn)

main = interact $ show . both (sum . map part1) (sum . map part2) . parse

both f g x = (f x, g x)

part1 :: [Rational] -> Int
part1 [ax, ay, bx, by, gx, gy] =
  let a = (gx - (bx / by) * gy) / (ax - (bx / by) * ay)
      b = (gx - (ax / ay) * gy) / (bx - (ax / ay) * by)
   in if closeEnough a && closeEnough b
        then round b + round a * 3
        else 0

part2 :: [Rational] -> Int
part2 xs =
  let [ax, ay, bx, by, gx, gy] =
        zipWith (+) xs [0, 0, 0, 0, 10000000000000, 10000000000000]
      a = (gx - (bx / by) * gy) / (ax - (bx / by) * ay)
      b = (gx - (ax / ay) * gy) / (bx - (ax / ay) * by)
   in if closeEnough a && closeEnough b
        then round b + round a * 3
        else 0

closeEnough :: Rational -> Bool
closeEnough x = abs (x - fromInteger (round x)) < 0.000001

parse :: String -> [[Rational]]
parse =
  map
    (map (toRational . (read :: String -> Double)) . words . map removeLetters)
    . splitOn "\n\n"

removeLetters c
  | isDigit c = c
  | otherwise = ' '
