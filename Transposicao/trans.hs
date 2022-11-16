import qualified Data.Char as C
import qualified Data.List as L

fazTabela :: Int -> String -> [String]
fazTabela n str
  | length str < n = [take n $ str ++ cycle "X"]
  | otherwise = take n str : fazTabela n (drop n str)

criptografa :: Int -> String -> String
criptografa k str = concat $ L.transpose $ fazTabela k str

doChosen :: [String] -> String
doChosen input
  | length input < 2 = "Entrada fora do padrão\n"
  | otherwise =
    criptografa (read k) (filter (\x -> not $ C.isSpace x) $ unwords str) ++
    "\n"
  where
    (k:str) = input

main :: IO ()
main = interact $ doChosen . words . map C.toUpper
