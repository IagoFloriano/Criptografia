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

subs1 :: U.Table -> U.ChCords -> String -> Int -> String
subs1 t cc (x:y:[]) d
  | not (C.isAlphaNum x && C.isAlphaNum y) || linx > 6 || liny > 6 = x : y : []
  | linx == liny = rightx : [righty]
  | colx == coly = underx : [undery]
  | otherwise = (t !! newlinx) !! newcoly : [(t !! newliny) !! newcolx]
  where
    rightx = (t !! newlinx) !! (mod (newcolx + 1) 6)
    righty = (t !! newliny) !! (mod (newcoly + 1) 6)
    underx = (t !! (mod (newlinx + 1) 6)) !! newcolx
    undery = (t !! (mod (newliny + 1) 6)) !! newcoly
    newlinx = mod (linx + d) 6
    newliny = mod (liny + d) 6
    newcolx = mod (colx + d) 6
    newcoly = mod (coly + d) 6
    (linx, colx) = cc M.! x
    (liny, coly) = cc M.! y

substitui :: U.Table -> U.ChCords -> [String] -> Int -> String
substitui _ cc [] _ = []
substitui t cc (x:xs) desloc =
  subs1 t cc x desloc ++ substitui t cc xs (mod (desloc + 1) 6)

encript :: String -> String -> String
encript _ [] = []
encript k str = substitui criptTable (U.makeCords criptTable) filteredStr 0
  where
    criptTable =
      U.makeTable k 6 6 $ L.nub $ L.nub k ++ ['A' .. 'Z'] ++ ['0' .. '9']
    filteredStr = toPairs $ filter (C.isAlphaNum) str

decript :: String -> String -> String
decript _ [] = []
decript k str = substitui deCriptTable (U.makeCords deCriptTable) filteredStr 0
  where
    deCriptTable =
      U.makeTable k 6 6 $
      reverse $ L.nub $ L.nub k ++ ['A' .. 'Z'] ++ ['0' .. '9']
    filteredStr = toPairs $ filter (C.isAlphaNum) str
