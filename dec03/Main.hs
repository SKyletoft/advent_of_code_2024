-- Run with: runhaskell Main.hs < input.txt
{-# LANGUAGE LambdaCase #-}

main = interact $ (++"\n") . show . both part1 part2

both f g s = (f s, g s)
isDigit d = d `elem` ("0123456789" :: [Char])
takeWhileNumber s =
  let nums = takeWhile isDigit s
  in (nums, drop (length nums) s)

part1 = sum . map (uncurry (*)) . parse
part2 = sum . map (uncurry (*)) . parse2

parse :: String -> [(Int, Int)]
parse = \case
  [] -> []
  ('m':'u':'l':'(':xs) ->
    let (left, rest) = takeWhileNumber xs
    in case rest of
      (',':ys) | not (null left) -> let (right, rest) = takeWhileNumber ys
                  in case rest of
                       (')':rest) | not (null right) ->
                                       (read left, read right):parse rest
                       rest -> parse rest
      rest -> parse rest
  (_:xs) -> parse xs

parse2 :: String -> [(Int, Int)]
parse2 = \case
  [] -> []
  ('d':'o':'n':'\'':'t':'(':')':xs) ->
    let dropUntil = \case
          "" -> []
          ('d':'o':'(':')':xs) -> parse2 xs
          (_:xs) -> dropUntil xs
    in dropUntil xs
  ('m':'u':'l':'(':xs) ->
    let (left, rest) = takeWhileNumber xs
    in case rest of
      (',':ys) | not (null left) -> let (right, rest) = takeWhileNumber ys
                  in case rest of
                       (')':rest) | not (null right) ->
                                       (read left, read right):parse2 rest
                       rest -> parse2 rest
      rest -> parse2 rest
  (_:xs) -> parse2 xs
