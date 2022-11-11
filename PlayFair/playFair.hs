import qualified Data.Char as C
import qualified Data.List as L
import qualified Data.Map as M

type Table = [[Char]]

type ChCords = M.Map Char (Int, Int)

tableToList :: Table -> Int -> [(Char, (Int, Int))]
tableToList t 5 = []
tableToList t l = zip (t !! l) [(l, i) | i <- [0 ..]] ++ tableToList t (l + 1)

makeCords :: Table -> ChCords
makeCords t = M.fromList $ tableToList t 0

vetToMat :: Int -> Int -> [b] -> [[b]]
vetToMat 0 _ _ = []
vetToMat x y vet = [take y vet] ++ vetToMat (x - 1) y (drop y vet)

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

subs1 :: Table -> ChCords -> String -> String
subs1 t cc (x:y:[])
  | not (C.isAlpha x && C.isAlpha y) || linx > 5 || liny > 5 = x : y : []
  | linx == liny = rightx : [righty]
  | colx == coly = underx : [undery]
  | otherwise = (t !! linx) !! coly : [(t !! liny) !! colx]
  where
    rightx = (t !! linx) !! (mod (colx + 1) 5)
    righty = (t !! liny) !! (mod (coly + 1) 5)
    underx = (t !! (mod (linx + 1) 5)) !! colx
    undery = (t !! (mod (liny + 1) 5)) !! coly
    (linx, colx) = cc M.! x
    (liny, coly) = cc M.! y

substitui :: Table -> ChCords -> [String] -> String
substitui _ cc [] = []
substitui t cc (x:xs) = subs1 t cc x ++ substitui t cc xs

makeTable :: String -> Table
makeTable key =
  vetToMat 5 5 $ L.nub $ iToJ (L.nub key) ++ ['A' .. 'H'] ++ ['J' .. 'Z']

criptografa :: String -> String -> String
criptografa _ [] = []
criptografa k str =
  substitui (makeTable k) (makeCords $ makeTable k) $
  toPairs $ filter (/= ' ') $ iToJ str

makeDeTable :: String -> Table
makeDeTable key =
  vetToMat 5 5 $
  reverse $ L.nub $ iToJ (L.nub key) ++ ['A' .. 'H'] ++ ['J' .. 'Z']

descriptografa :: String -> String -> String
descriptografa _ [] = []
descriptografa k str =
  substitui (makeDeTable k) (makeCords $ makeDeTable k) $
  toPairs $ filter (/= ' ') $ iToJ str

doChosen :: [String] -> String
doChosen (a:k:str)
  | length (a : k : str) < 3 = ""
  | a == "DE" = descriptografa k (unwords str) ++ "\n"
  | otherwise = criptografa k (unwords str) ++ "\n"

main :: IO ()
main = interact $ doChosen . words . map C.toUpper
