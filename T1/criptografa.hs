import qualified Data.Char as C
import qualified Data.List as L
import qualified Data.Map as M
import qualified PlayFair as PF
import qualified Util as U
import qualified Viegenere as V

encript :: [String] -> String
encript input
  | length input < 3 =
    "Entrada dada de forma incorreta\n deve ser: [chave play fair] [chave viegenere] [texto a ser criptografado]"
  | otherwise = (V.encript kvg $ PF.encript kpf $ unwords str) ++ "\n"
  where
    (kpf:kvg:str) = input

main :: IO ()
main = interact $ encript . words . filter C.isAscii . map C.toUpper
