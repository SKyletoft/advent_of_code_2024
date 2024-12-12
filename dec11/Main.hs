{-# LANGUAGE LambdaCase #-}

module Main where

import Data.IntMap.Strict qualified as M
import Prelude hiding (repeat)

type IMap = M.IntMap Int

main = interact $ (++ "\n") . show . solve . parse

mergeStones = foldr (\(k, v) -> snd . M.insertLookupWithKey (const (+)) k v) M.empty

parse = mergeStones . map ((,1) . read) . words

both (f, g) x = (f x, g x)

solve :: IMap -> (Int, Int)
solve = both (finalise, finalise . repeat 50 generation) . repeat 25 generation
  where
    finalise = sum . map snd . M.toList
    generation = mergeStones . concatMap perStone . M.toList
    perStone =
      \case
        (0, n) -> pure (1, n)
        (m, n)
          | odd . floor . logBase 10 . fromIntegral $ m ->
              let digits =
                    (`div` 2) . (1 +) . floor . logBase 10 . fromIntegral $ m
                  left = m `div` 10 ^ digits
                  right = m `mod` 10 ^ digits
               in [(left, n), (right, n)]
        (m, n) -> pure (m * 2024, n)

repeat :: Int -> (a -> a) -> a -> a
repeat =
  \cases
    0 _ x -> x
    n f x -> repeat (n - 1) f (f x)
