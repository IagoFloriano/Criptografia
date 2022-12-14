module Util
  ( tableToList
  , makeCords
  , vetToMat
  , makeTable
  , Table
  , ChCords
  ) where

import qualified Data.Char as C
import qualified Data.List as L
import qualified Data.Map as M

type Table = [[Char]]

type ChCords = M.Map Char (Int, Int)

tableToList :: Table -> Int -> [(Char, (Int, Int))]
tableToList [] _ = []
tableToList t l =
  zip (head t) [(l, i) | i <- [0 ..]] ++ tableToList (tail t) (l + 1)

makeCords :: Table -> ChCords
makeCords t = M.fromList $ tableToList t 0

vetToMat :: Int -> Int -> [b] -> [[b]]
vetToMat 0 _ _ = []
vetToMat x y vet = [take y vet] ++ vetToMat (x - 1) y (drop y vet)

makeTable :: String -> Int -> Int -> String -> Table
makeTable key i j str = vetToMat i j str
