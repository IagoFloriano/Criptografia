module PlayFair
  ( encript
  , decript
  ) where

import qualified Data.Char as C
import qualified Data.List as L
import qualified Data.Map as M
import qualified Util as U

iToJ :: String -> String
iToJ [] = []
iToJ (x:xs)
  | x == 'I' = 'J' : iToJ xs
  | otherwise = x : iToJ xs

toPairs :: String -> [String]
toPairs [] = []
toPairs (x:y:xs)
  | x /= y = [x : y : []] ++ toPairs xs
  | otherwise = [x : "X"] ++ toPairs (y : xs)
toPairs (x:[]) = [x : "X"]

subs1 :: U.Table -> U.ChCords -> String -> String
subs1 t cc (x:y:[])
  | not (C.isAlphaNum x && C.isAlphaNum y) || linx > 6 || liny > 6 = x : y : []
  | linx == liny = rightx : [righty]
  | colx == coly = underx : [undery]
  | otherwise = (t !! linx) !! coly : [(t !! liny) !! colx]
  where
    rightx = (t !! linx) !! (mod (colx + 1) 6)
    righty = (t !! liny) !! (mod (coly + 1) 6)
    underx = (t !! (mod (linx + 1) 6)) !! colx
    undery = (t !! (mod (liny + 1) 6)) !! coly
    (linx, colx) = cc M.! x
    (liny, coly) = cc M.! y

substitui :: U.Table -> U.ChCords -> [String] -> String
substitui _ cc [] = []
substitui t cc (x:xs) = subs1 t cc x ++ substitui t cc xs

encript :: String -> String -> String
encript _ [] = []
encript k str = substitui criptTable (U.makeCords criptTable) filteredStr
  where
    criptTable =
      U.makeTable k 6 6 $ L.nub $ L.nub k ++ ['A' .. 'Z'] ++ ['0' .. '9']
    filteredStr = toPairs $ filter (C.isAlphaNum) str

decript :: String -> String -> String
decript _ [] = []
decript k str = substitui deCriptTable (U.makeCords deCriptTable) filteredStr
  where
    deCriptTable =
      U.makeTable k 6 6 $
      reverse $ L.nub $ L.nub k ++ ['A' .. 'Z'] ++ ['0' .. '9']
    filteredStr = toPairs $ filter (C.isAlphaNum) str
