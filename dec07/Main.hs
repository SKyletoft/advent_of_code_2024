{-# LANGUAGE LambdaCase #-}

module Main where

import           Data.List.Extra (splitOn)

main = interact $ (++ "\n") . show . both part1 part2 . map parse . lines

both f g x = (f x, g x)

part1 = sum . map fst . filter (uncurry solve1)

part2 = sum . map fst . filter (uncurry solve2)

solve1 :: Int -> [Int] -> Bool
solve1 goal (x:xs) = solve' goal x xs
  where
    solve' goal acc =
      \case
        _
          | acc > goal -> False
        (x:xs) -> solve' goal (acc + x) xs || solve' goal (acc * x) xs
        _ -> goal == acc

solve2 :: Int -> [Int] -> Bool
solve2 goal (x:xs) = solve' goal x xs
  where
    solve' goal acc =
      \case
        _
          | acc > goal -> False
        (x:xs) ->
          solve' goal (acc + x) xs
            || solve' goal (acc * x) xs
            || solve' goal (acc // x) xs
        _ -> goal == acc

x // y =
  let digits = (1 +) . floor . logBase 10 . fromIntegral $ y
   in x * 10 ^ digits + y

parse :: String -> (Int, [Int])
parse s =
  let [x, xs] = splitOn ":" s
   in (read x, map read $ words xs)
