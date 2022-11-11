import qualified Data.Char as C
import qualified Data.List as L
import qualified Data.Map as M
import Data.Maybe (fromJust)

type Table = [[Char]]

vetToMat :: Int -> Int -> [b] -> [[b]]
vetToMat 0 _ _ = []
vetToMat x y vet = [take y vet] ++ vetToMat (x - 1) y (drop y vet)

type ChCords = M.Map Char (Int, Int)

tableToList :: Table -> Int -> [(Char, (Int, Int))]
tableToList t 26 = []
tableToList t l = zip (t !! l) [(l, i) | i <- [0 ..]] ++ tableToList t (l + 1)

makeCords :: Table -> ChCords
makeCords t = M.fromList $ tableToList t 0

tableString :: Int -> String
tableString 26 = []
tableString x =
  take 26 (drop (26 - x) $ cycle ['A' .. 'Z']) ++ tableString (x + 1)

makeTable :: Table
makeTable = vetToMat 26 26 $ tableString 0

criptografa :: String -> String -> String
criptografa _ [] = []
criptografa [] _ = []
criptografa (k:ks) (x:xs)
  | C.isLetter x = (makeTable !! ko) !! xo : criptografa ks xs
  | otherwise = x : criptografa ks xs
  where
    ko = C.ord k - C.ord 'A'
    xo = C.ord x - C.ord 'A'

findDes :: Char -> Char -> Table -> Int -> Int
findDes k x t n
  | fromJust (L.elemIndex x (t !! n)) == (C.ord k - C.ord 'A') = n + C.ord 'A'
  | otherwise = findDes k x t (n + 1)

descriptografa :: String -> String -> String
descriptografa _ [] = []
descriptografa [] _ = []
descriptografa (k:ks) (x:xs)
  | C.isLetter x = C.chr (findDes k x makeTable 0) : descriptografa ks xs
  | otherwise = x : descriptografa ks xs

doChosen :: [String] -> String
doChosen (a:k:str)
  | length (a : k : str) < 3 = ""
  | a == "DE" =
    descriptografa (cycle $ filter C.isLetter k) (unwords str) ++ "\n"
  | otherwise = criptografa (cycle $ filter C.isLetter k) (unwords str) ++ "\n"

main :: IO ()
main = interact $ doChosen . words . map C.toUpper
