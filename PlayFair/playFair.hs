import Data.Char (chr, ord)

type Table = [[Char]]

contains :: Eq a => a -> [a] -> Bool
contains _ [] = False
contains a (x:xs)
  | x == a = True
  | otherwise = contains a xs

remove :: Eq a => a -> [a] -> [a]
remove _ [] = []
remove a (x:xs)
  | a == x = remove a xs
  | otherwise = x : remove a xs

unique :: Eq a => [a] -> [a]
unique [] = []
unique (x:xs) = x : unique (remove x xs)

addalphabet :: Char -> String -> String
addalphabet 'I' str = addalphabet 'J' str
addalphabet c str
  | length str == 25 = str
  | contains c str = addalphabet nextc str
  | otherwise = addalphabet nextc $ str ++ [c]
  where
    nextc = chr (ord c + 1)

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

subs1 :: Table -> String -> String
subs1 t (x:y:[])
  | linx > 5 || liny > 5 = x : y : []
  | linx == liny =
    (t !! linx) !! (mod (colx + 1) 5) : [(t !! liny) !! (mod (coly + 1) 5)]
  | colx == coly =
    (t !! (mod (linx + 1) 5)) !! colx : [(t !! (mod (liny + 1) 5)) !! coly]
  | otherwise = (t !! linx) !! coly : [(t !! liny) !! colx]
  where
    linx = getLin t x 0
    liny = getLin t y 0
    colx = getCol (t !! linx) x 0
    coly = getCol (t !! liny) y 0

getLin :: Table -> Char -> Int -> Int
getLin t c 5 = 6
getLin t c n
  | contains c (t !! n) = n
  | otherwise = getLin t c (n + 1)

getCol :: String -> Char -> Int -> Int
getCol [] _ _ = error "NAO TEM"
getCol (t:ts) c n
  | t == c = n
  | otherwise = getCol ts c (n + 1)

substitui :: Table -> [String] -> String
substitui _ [] = []
substitui t (x:xs) = subs1 t x ++ substitui t xs

makeTable :: String -> Table
makeTable key = vetToMat 5 5 (addalphabet 'A' $ iToJ keynodupe)
  where
    keynodupe = unique key

criptografa :: String -> String -> String
criptografa _ [] = []
criptografa k str = substitui (makeTable k) $ toPairs $ remove ' ' $ iToJ str

makeDeTable :: String -> Table
makeDeTable key = vetToMat 5 5 (reverse $ addalphabet 'A' $ iToJ keynodupe)
  where
    keynodupe = unique key

descriptografa :: String -> String -> String
descriptografa _ [] = []
descriptografa k str =
  substitui (makeDeTable k) $ toPairs $ remove ' ' $ iToJ str

doChosen :: [String] -> String
doChosen (a:k:str)
  | length (a : k : str) < 3 = ""
  | a == "DE" = descriptografa k (unwords str) ++ "\n"
  | otherwise = criptografa k (unwords str)

main :: IO ()
main = interact $ doChosen . words
