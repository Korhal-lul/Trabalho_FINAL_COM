module Main where

import qualified Lex as L
import Parser (calc)
import System.IO

main :: IO ()
main = do
  handle <- openFile "teste.j--_" ReadMode
  contents <- hGetContents handle
  print (calc (L.alexScanTokens contents))
  hClose handle
