import System.Environment (getArgs)
import Lex (alexScanTokens)
import Parser (calc)
import DataTree
import Semantic (verificaPrograma)
import JVM (gerar)

main :: IO ()
main = do
  args <- getArgs
  content <- case args of
    []      -> getContents
    (f:_)   -> readFile f
  let tokens = alexScanTokens content
  let ast = calc tokens
  case verificaPrograma ast of
    Left msg -> putStrLn msg
    Right (astFinal, avisos) -> do
      putStrLn (unlines avisos)
      putStrLn "AST Final analisada."

      let nomeClasse = "output"
      let jvmCode = gerar nomeClasse astFinal
      print astFinal
      writeFile (nomeClasse ++ ".j") jvmCode
      putStrLn $ "Código Jasmin salvo em: " ++ nomeClasse ++ ".j"

{- main = do putStr "Arquivo"
          arq <- getLine
          txt <- readFile arq
          putStr txt
-}