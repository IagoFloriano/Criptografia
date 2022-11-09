import Data.Char (ord)

--- TRADUÇÃO {
translate =
  [ 'P'
  , 'F'
  , 'J'
  , 'W'
  , 'B'
  , 'A'
  , 'H'
  , 'U'
  , 'R'
  , 'M'
  , '6'
  , 'K'
  , 'D'
  , 'T'
  , 'Z'
  , 'Q'
  , 'N'
  , 'E'
  , 'L'
  , 'V'
  , '6'
  , 'I'
  , 'G'
  , 'C'
  , 'O'
  , 'S'
  ] ---}

descript :: String -> String
descript [] = []
descript (x:xs)
  | ord x <= ord 'Z' && ord x >= ord 'A' =
    translate !! (ord x - ord 'A') : descript xs
  | x == '_' = ' ' : descript xs
  | otherwise = x : descript xs

main :: IO ()
main = interact $ descript
