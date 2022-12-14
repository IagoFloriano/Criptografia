import qualified Data.Char as C
import qualified Data.List as L
import qualified Data.Map as M

type Table = [[Char]]

type ChCords = M.Map Char (Int, Int)

--General Functions{
tableToList :: Table -> Int -> [(Char, (Int, Int))]
tableToList [] _ = []
tableToList t l = zip (head t) [(l, i) | i <- [0 ..]] ++ tableToList t (l + 1)

makeCords :: Table -> ChCords
makeCords t = M.fromList $ tableToList t 0

vetToMat :: Int -> Int -> [b] -> [[b]]
vetToMat 0 _ _ = []
vetToMat x y vet = [take y vet] ++ vetToMat (x - 1) y (drop y vet)

makeTable :: String -> Int -> Int -> String -> Table
makeTable key i j str = vetToMat i j str

--}
--Play fair functions {
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

pfsubs1 :: Table -> ChCords -> String -> String
pfsubs1 t cc (x:y:[])
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

pfsubstitui :: Table -> ChCords -> [String] -> String
pfsubstitui _ cc [] = []
pfsubstitui t cc (x:xs) = pfsubs1 t cc x ++ pfsubstitui t cc xs

playFair :: String -> String -> String
playFair _ [] = []
playFair k str = pfsubstitui criptTable (makeCords $ criptTable) filteredStr
  where
    criptTable =
      makeTable k 5 5 $ L.nub $ iToJ (L.nub k) ++ ['A' .. 'H'] ++ ['J' .. 'Z']
    filteredStr = toPairs $ filter (C.isLetter) $ iToJ str

--}
--Viegenere Functions {
tableString :: Int -> String
tableString 26 = []
tableString x = take 26 (drop x $ cycle ['A' .. 'Z']) ++ tableString (x + 1)

viegenere :: String -> String -> String
viegenere _ [] = []
viegenere [] _ = []
viegenere (k:ks) (x:xs)
  | C.isLetter x = (viegTable !! ko) !! xo : viegenere (ks ++ [x]) xs
  | otherwise = x : viegenere (k : ks) xs
  where
    viegTable = vetToMat 26 26 $ tableString 0
    ko = C.ord k - C.ord 'A'
    xo = C.ord x - C.ord 'A'

--}
main :: IO ()
main = undefined
