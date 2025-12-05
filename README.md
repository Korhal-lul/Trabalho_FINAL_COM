# Trabalho final de Compiladores
---
## 📚 Sumário  

- [📄 Descrição](#-descrição)  
- [🔨 Etapas do Trabalho](#-etapas-do-trabalho)
- [📝 Recomendações Para Passar em COM](#-recomendações)
- [⚙️ Funcionamento](#️-funcionamento)  
- [🧩 Estrutura do Projeto](#-estrutura-do-projeto)  
- [▶️ Como Compilar e Executar](#️-como-compilar)
---


## 📄 Descrição  
Este projeto implementa um **compilador semi-completo**, escrito em **Haskell** utilizando **Alex**, **Happy** e **Jasmin**, que traduz um subconjunto da linguagem **C** para **bytecode JVM**.  
Realizando as seguintes etapas:

- **Análise Léxica**  
- **Análise Sintática**  
- **Análise Semântica**  
- **Geração de Código Assembly Jasmin**

O resultado final é um arquivo `.class` executável na Máquina Virtual Java (JVM).

---

## 🔨 Etapas do Trabalho 

Durante a disciplina, o trabalho foi dividido em partes independentes. Em algumas edições é solicitado entregar as três etapas; ao final da matéria acontece uma implementação prática em sala de aula para avaliar o trabalho completo.  
A atividade final apresenta sempre duas versões:

- **Fácil (70% da nota)**
- **Difícil (100% da nota)**

### Requisitos solicitados em 2025:

#### **2025/1**
- **Fácil:** implementar incremento `i++;`  
- **Difícil:** implementar o comando `for`

#### **2025/2**
- **Fácil:** implementar o operador aritmético MOD `%`  
- **Difícil:** adicionar o tipo `float` (para operações aritméticas)

Cada parte do trabalho está separada em uma branch contendo o PDF do enunciado e seu respectivo código.

**Branches:**
- **Primeira Parte:** `Primeira-Parte`
- **Segunda Parte:** `Segunda-Parte`
- **Terceira Parte:** `Master`
- **Terceira Parte (Apresentação):** `Extra`

## Recomendações

O conteúdo em si é um tanto extenso porém a prova é uma questão simples dos temas abordados em sala.

#### Aulas que não se pode faltar

Provas e trabalhos obviamente, aulas sobre tabelas SLR, LR e LL(1) pois esses conteúdos existem na internet para estudar, porém são escassos e com métodos muito complicados e isso inclui o grande Prof. José rui.

#### Atividades 

Elas são três ao total e ele ajuda a fazer em sala, a entrega de todas vale 20% da nota final.

#### Trabalhos

Não vacile pois vale 50% da nota final. O importante é entregar no prazo, pois ele dá a nota do trabalho baseado na apresentação final, que foi comentada anteriormente, as entregas servem para reduzir a nota da aprensentação, para cada trabalho não entregue ele retira 1 ponto.

#### Provas

No semestre 2025/2 só teve uma unidade de prova que valia 30% da nota final, ela cobria tradução de código Java para o bytecode, tabela LR e tabela LL(1) (SEMPRE cai duas tabelas e uma é SEMPRE a LL(1), a outra pode variar) e uma questão sobre token.

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
