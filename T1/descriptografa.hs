import qualified Data.Char as C
import qualified Data.List as L
import qualified Data.Map as M
import qualified PlayFair as PF
import qualified Util as U
import qualified Viegenere as V

decript :: [String] -> String
decript input
  | length input < 3 =
    "Entrada dada de forma incorreta\n deve ser: [chave play fair] [chave viegenere] [texto a ser descriptografado]"
  | otherwise = PF.decript kpf $ V.decript kvg $ unwords str
  where
    (kpf:kvg:str) = input

main :: IO ()
main = interact $ decript . words . map C.toUpper
