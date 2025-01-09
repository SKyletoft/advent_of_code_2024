{-# LANGUAGE GHC2021     #-}
{-# LANGUAGE LambdaCase  #-}
{-# OPTIONS_GHC -Wno-x-partial #-}

import           Data.Map ((!), (!?))
import qualified Data.Map as M
import           Prelude  hiding (Left, Right)

type Map k v = M.Map k v

type Game = (Map (Int, Int) Char, (Int, Int))

main = interact $ (++ "\n") . show . both part1 part2 . parse

both f g x = (f x, g x)

part1 (g, size) =
  let (finalDir, (finalMap, finalPos)) = repeatUntil (limit size) step (Up, g)
   in length . filter ((`elem` "←↓↑→") . snd) . M.toList $ finalMap

part2 (g, size) =
  let (_, (finalMap, _)) = repeatUntil (limit size) step (Up, g)
   in length
        . filter (not . limit size)
        . map
            ((\x -> repeatUntil (loopLimit size) step (Up, x))
               . addBlockade g
               . fst)
        . M.toList
        . M.filter (`elem` "←↓↑→")
        $ finalMap

addBlockade :: Game -> (Int, Int) -> Game
addBlockade (m, p) at = (M.insert at '#' m, p)

parse :: String -> (Game, (Int, Int))
parse x =
  let m =
        M.fromList
          . concatMap (\ys -> zipWith (\(x, c) y -> ((x, y), c)) ys [0 ..])
          . zipWith (\i s -> map (i, ) s) [0 ..]
          . lines
          $ x
      pos = fst . head . filter ((== '^') . snd) . M.toList $ m
      w = length (lines x) - 1
      h = (length . head . lines $ x) - 1
   in ((m, pos), (w, h))

data Dir
  = Left
  | Right
  | Up
  | Down
  deriving (Show)

dirToVector (y, x) =
  \case
    Up    -> (y - 1, x)
    Down  -> (y + 1, x)
    Right -> (y, x + 1)
    Left  -> (y, x - 1)

rotate =
  \case
    Up    -> Right
    Right -> Down
    Down  -> Left
    Left  -> Up

dirToChar =
  \case
    Up    -> '↑'
    Down  -> '↓'
    Left  -> '←'
    Right -> '→'

step :: (Dir, Game) -> (Dir, Game)
step (dir, g@(m, v@(y, x))) =
  if m !? dirToVector v dir
       `elem` [Just '.', Just '←', Just '↑', Just '↓', Just '→', Nothing]
    then let m' = M.insert v (dirToChar dir) m
          in (dir, (m', dirToVector v dir))
    else (rotate dir, g)

limit :: (Int, Int) -> (Dir, Game) -> Bool
limit (xMax, yMax) (_, (_, (y, x))) =
  y < 0 || y >= yMax || x < 0 || x >= xMax

loopLimit :: (Int, Int) -> (Dir, Game) -> Bool
loopLimit (xMax, yMax) g@(dir, (m, p@(y, x))) =
  y < 0 || y >= yMax || x < 0 || x >= xMax || m ! p == dirToChar dir

repeatUntil :: (a -> Bool) -> (a -> a) -> a -> a
repeatUntil pred f x
  | pred x = f x
  | otherwise = repeatUntil pred f (f x)
