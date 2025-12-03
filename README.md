# Trabalho final de Compiladores
---
## 📚 Sumário  

- [📄 Descrição](#-descrição)  
- [⚙️ Funcionamento](#️-funcionamento)  
- [🧩 Estrutura do Projeto](#-estrutura-do-projeto)  
- [▶️ Como Compilar e Executar](#️-como-compilar)  
---

## 📄 Descrição  
Este projeto implementa um compilador semi-completo, escrito em Haskell usando Alex, Happy e Jasmin, que traduz um subconjunto de C para bytecode JVM.
O compilador realiza análise léxica, sintática, semântica e gera código assembly para a Máquina Virtual Java.
A branch extra possui funções adicionais implementadas, como mod, exponencial, arrays, com dicas para se modificar.

## ⚙️ Funcionamento

O processo de compilação segue quatro etapas:

Lexer (Alex) – converte o código-fonte em tokens.

Parser (Happy) – constrói a AST conforme a gramática definida.

Análise Semântica – valida tipos, variáveis, escopos e comandos.

Geração de Código JVM – emite bytecode através de arquivos .j para o Jasmin montar.

O resultado final é um arquivo .class executável na JVM.

##  🧩 Estrutura do Projeto
/src

 ├── Lex.x        # Lexer (Alex)
 
 ├── Parser.y     # Parser (Happy)
 
 ├── Token.hs     # Definição dos tokens
 
 ├── DataTree.hs  # AST
 
 ├── Semantic.hs  # Analisador semântico
 
 ├── JVM.hs       # Geração de bytecode Jasmin
 
 ├── teste.j--_   # Codigo exemplo de entrada
 
 └── main.hs      # Pipeline do compilador

## ▶️ Como compilar

alex Lex.x

happy Parser.y

ghc -o main main.hs

./main teste.j--_

java -jar PATH_TO_jasmin.jar output.j
