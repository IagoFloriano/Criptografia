module Viegenere
  ( encript
  , decript
  ) where

import qualified Data.Char as C
import qualified Data.List as L
import qualified Data.Map as M
import Data.Maybe (fromJust)
import qualified Util as U

tableString :: Int -> String
tableString 26 = []
tableString x = take 26 (drop x $ cycle ['A' .. 'Z']) ++ tableString (x + 1)

viegTable :: U.Table
viegTable = U.vetToMat 26 26 $ tableString 0

encript :: String -> String -> String
encript _ [] = []
encript [] _ = []
encript (k:ks) (x:xs)
  | C.isLetter x = (viegTable !! ko) !! xo : encript (ks ++ [x]) xs
  | otherwise = x : encript (k : ks) xs
  where
    ko = C.ord k - C.ord 'A'
    xo = C.ord x - C.ord 'A'

findDes :: Char -> Char -> U.Table -> Char
findDes k x t = C.chr $ (fromJust (L.elemIndex x (t !! ko))) + C.ord 'A'
  where
    ko = C.ord k - C.ord 'A'

decript :: String -> String -> String
decript _ [] = []
decript [] _ = []
decript (k:ks) (x:xs)
  | C.isLetter x = curChar : decript (ks ++ [curChar]) xs
  | otherwise = x : decript (k : ks) xs
  where
    curChar = findDes k x viegTable
