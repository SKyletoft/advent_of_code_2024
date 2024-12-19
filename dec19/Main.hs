{-# LANGUAGE LambdaCase #-}

module Main where

import           Control.Monad.RWS (RWS, get, modify, put, runRWS, tell)
import           Data.List.Split   (splitOn)
import qualified Data.Map          as Map
import           Data.Maybe        (mapMaybe)
import           Debug.Trace
import           GHC.IO.Unsafe     (unsafePerformIO)
import qualified GHC.IORef         as IORef

main = interact $ (++ "\n") . show . part1 . parse

part1 :: ([String], [String]) -> Int
part1 (patterns, problems) =
  let solve :: [String] -> Bool
      solve =
        \case
          [] -> False
          xs
            | "" `elem` xs -> True
          xs ->
            let withoutPrefix = do
                  pat <- patterns
                  string <- xs
                  asList $ parsePrefix pat string
             in solve withoutPrefix
   in length . filter (solve . return) $ problems

first f (x, y) = (f x, y)

asList =
  \case
    Just x -> [x]
    Nothing -> []

parsePrefix :: String -> String -> Maybe String
parsePrefix prefix s
  | take l s == prefix = Just $ drop l s
  | otherwise = Nothing
  where
    l = length prefix

parse :: String -> ([String], [String])
parse s =
  let [types, problems] = splitOn "\n\n" s
   in (splitOn ", " types, lines problems)
