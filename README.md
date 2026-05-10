# Universal Abstract Language (U) — Documentação da Linguagem

```text
    []---------[]       []---------[]     u-shell ~ version 1.3.0 (Governor)
    | \       / |       | \       / |     --------------------------------------------------
    |  []---[]  |       |  []---[]  |     Project: Universal Abstract Language (U)
    []--| \ |--[]       []--| / |--[]     Paradigm: AI-First, Functional Pipelines, Contexts
    | \ |  [] \ |       | / []  | / |     compiler: U-VM v2.1 (AML Protocol)
    |  [] / |  []       []  | \ []  |
    []--|-\-|--/-\-----/-\--|-/--|--[]     Ownership: Governor Ltda. (https://governor.ltd)
     \  |  [] /   []-[]   \ []  |  /       Developed by Claudemir Casa
      \[] /  \   /  |  \   /  \ []/         Copyright: (c) 2026 Governor Ltda.
       \ /    \ /   |   \ /    \ /
        []----[]---[]---[]----[]               Ready for directives.
          \    \   / \   /    /                [_U_] { ? }
           \    []-----[]    /
            \---------------/
```

A **Universal Abstract Language (U)** é uma linguagem de programação moderna focada em AI-First, Pipelines Funcionais e "Coleções como Contextos". Projetada para ser extremamente limpa e expressiva, eliminando as verbosidades de linguagens tradicionais.

**Regras de Ouro:**

- **Sem parênteses** — funções usam `[]` em vez de `()`.
- **Sem `if`/`else`, `for`/`while`** — controle de fluxo via `match`, `guard` e `each`.
- **Coleções são Contextos** — mapas e listas são cidadãos de primeira classe.
- **AI-First** — funções podem delegar computação nativamente a um agente LLM via diretivas.
- **Ponto-e-vírgula Opcional** — usado apenas para separar expressões na mesma linha.

---

## Índice

1. [Instalação](#1-instalação)
2. [Tipos Primitivos](#2-tipos-primitivos)
3. [Variáveis e Fluxo de Dados](#3-variáveis-e-fluxo-de-dados)
4. [Comentários](#4-comentários)
5. [Strings e Interpolação](#5-strings-e-interpolação)
6. [Operadores](#6-operadores)
7. [Coleções: Listas e Mapas](#7-coleções-listas-e-mapas)
8. [Controle de Fluxo](#8-controle-de-fluxo)
9. [Iteração](#9-iteração)
10. [Funções (Closures)](#10-funções-closures)
11. [Sistema de Tipos (`is`, `as`)](#11-sistema-de-tipos-is-as)
12. [Assincronismo (`async`/`await`)](#12-assincronismo-asyncawait)
13. [Diretivas de Agente IA](#13-diretivas-de-agente-ia)
14. [Módulos](#14-módulos)

---

## 1. Instalação

Os arquivos da linguagem U utilizam a extensão **`.u`**.

### macOS via Homebrew (recomendado)

```bash
brew install claudemircasa/u/u
```

---

## 2. Tipos Primitivos

U possui quatro tipos primitivos fundamentais:

| Tipo      | Exemplo                        |
|-----------|--------------------------------|
| `Number`  | `42`, `3.14`, `-7`             |
| `String`  | `"olá"`, `"valor: {x}"`       |
| `Boolean` | `true`, `false`                |
| `Null`    | `null`                         |

```u
idade: 25
preco: 19.99
nome: "Alice"
ativo: true
vazio: null
```

---

## 3. Variáveis e Fluxo de Dados

### Declaração com `:`

O operador `:` declara e vincula um valor a um nome no contexto atual.

```u
score: 10 + 5 * 2
mensagem: "Olá, mundo!"
```

### Sinks e Sources: `->`, `<-`, `out`, `in`

O fluxo de dados é direcional. `->` envia um valor para um destino (sink); `<-` captura um valor de uma fonte (source).

```u
// Saída para o terminal
"Iniciando..." -> out
score -> out

// Entrada do terminal
"Qual seu nome?" -> out
nome <- in
"Olá, {nome}!" -> out
```

`out` é o sink padrão (stdout). `in` é o source padrão (stdin).

---

## 4. Comentários

### Linha (`//`)

```u
// Isso é um comentário de linha
score: 42  // inline também funciona
```

### Bloco (`{% %}`)

```u
{%
  Comentário de bloco.
  Pode ocupar múltiplas linhas.
  Ideal para cabeçalhos de arquivo.
%}
```

---

## 5. Strings e Interpolação

Strings são delimitadas por aspas duplas. A interpolação é feita com `{}`.

### Variável simples

```u
nome: "Mundo"
"Olá, {nome}!" -> out
```

### Acesso a propriedade

```u
usuario: { nome: "Alice", idade: 30 }
"Usuário: {usuario.nome}, idade: {usuario.idade}" -> out
```

### Acesso encadeado

```u
res: { v0: 1, v1: 2 }
"Resultado: [{res.v0}, {res.v1}]" -> out
```

---

## 6. Operadores

### Aritméticos

| Operador | Descrição                         | Exemplo         |
|----------|-----------------------------------|-----------------|
| `+`      | Adição                            | `3 + 2` → `5`  |
| `-`      | Subtração                         | `5 - 2` → `3`  |
| `*`      | Multiplicação                     | `4 * 3` → `12` |
| `/`      | Divisão (ponto flutuante)         | `7 / 2` → `3.5`|
| `%`      | Módulo (resto)                    | `7 % 2` → `1`  |
| `**`     | Potenciação                       | `2 ** 8` → `256`|
| `div`    | Divisão inteira (floor)           | `7 div 2` → `3`|

```u
mid: (lo + hi) div 2
resto: 10 % 3
pot: 2 ** 10
```

### Comparação

```u
maior:   10 > 5       // true
menor:   3 < 7        // true
igual:   4 == 4       // true
diferente: 4 != 5     // true
gte:     10 >= 10     // true
lte:     3 <= 4       // true
```

### Lógicos

`and`, `or` e `not` substituem `&&`, `||`, `!`. `and` e `or` fazem curto-circuito.

```u
aprovado: nota > 7 and presenca >= 75
reprovado: nota < 5 or presenca < 75
invalido: not ativo

// Curto-circuito seguro: j > 0 evita acesso inválido ao índice
deve_trocar: j > 0 and val_j < arr[j - 1]
```

### Null-safe

| Operador | Descrição                              | Exemplo                    |
|----------|----------------------------------------|----------------------------|
| `?.`     | Optional chaining — não explode se null| `usuario?.endereco?.rua`   |
| `??`     | Null coalescing — fallback se null     | `valor ?? 0`               |

```u
rua: usuario?.endereco?.rua
idade_final: idade ?? 18
```

### Range

```u
1..5    // range fechado: 1, 2, 3, 4, 5
0..9    // 0 a 9
```

### Spread

```u
base: [1, 2, 3]
completo: [0, ...base, 4, 5]   // [0, 1, 2, 3, 4, 5]
```

---

## 7. Coleções: Listas e Mapas

### Listas

```u
numeros: [10, 20, 30, 40]
primeiro: numeros[0]    // 10
terceiro: numeros[2]    // 30
```

O índice usa `[]` — a mesma sintaxe de chamada de função. Listas são indexadas a partir de `0`.

### Mapas (Dicionários)

```u
cliente: { id: 100, nome: "Alice", plano: "Premium" }

// Acesso a propriedade
cliente.nome -> out       // "Alice"
cliente.plano -> out      // "Premium"
```

Mapas são estruturas imutáveis. Para "modificar" um campo, crie um novo mapa:

```u
atualizado: { id: cliente.id, nome: "Bob", plano: cliente.plano }
```

### Listas vs Mapas em match

Mapas são delimitados por `{ }` com campos separados por vírgula. Blocos de código também usam `{ }` — o parser os distingue: presença de vírgula no nível raiz da chave indica mapa; ausência indica bloco de código.

---

## 8. Controle de Fluxo

### `match` com default `_`

Substitui `if/else` e `switch/case`. O underscore `_` é o caso padrão.

```u
status: 404

match status {
    200: "OK" -> out
    404: "Não encontrado" -> out
    _:   "Erro desconhecido" -> out
}
```

`match` também funciona como expressão (retorna valor):

```u
descricao: match status {
    200: "OK"
    404: "Não encontrado"
    _:   "Erro"
}
```

### `when` — guard arms

`when` avalia uma condição booleana arbitrária em vez de igualdade. Útil para branches com expressões relacionais.

```u
match val {
    when val == target: mid
    when val < target:  busca[arr, mid + 1, high, target]
    _:                  busca[arr, low, mid - 1, target]
}
```

```u
resultado: match 0 {
    when left_done:  false
    when right_done: true
    _:               val_i <= val_j
}
```

`when` e arms de igualdade podem ser misturados no mesmo `match`.

### Block arms — lazy evaluation

Um arm pode conter um bloco de código `{ }` em vez de uma expressão simples. O bloco só é avaliado quando o arm é selecionado — essencial para recursão sem avaliação antecipada.

```u
ms: [arr, lo, hi] {
    match lo >= hi {
        true: arr
        _: {
            mid:      (lo + hi) div 2
            esq:      ms[arr, lo, mid]
            dir:      ms[esq, mid + 1, hi]
            merge[dir, lo, mid, hi]
        }
    }
}
```

Sem block arm, o arm `_` seria avaliado imediatamente, causando recursão infinita.

### `guard`

Early-return condicional: se a condição for falsa, executa a expressão após `else` e interrompe o bloco.

```u
guard usuario.autenticado else "Acesso negado" -> out
guard saldo > 0 else { "Saldo insuficiente" -> out }
```

---

## 9. Iteração

### `each...in` com range

```u
each i in 0..4 {
    i -> out
}
```

### `each...in` com lista

```u
nomes: ["Alice", "Bob", "Carol"]
each nome in nomes {
    "Olá, {nome}!" -> out
}
```

### `each...when...yield` — list comprehension

Filtra e transforma uma coleção em uma nova lista.

```u
pares: each n in 1..10 when n % 2 == 0 yield n * 10
// pares = [20, 40, 60, 80, 100]
pares -> out
```

Sem `when`, filtra nada (transforma todos):

```u
dobros: each n in 1..5 yield n * 2
// dobros = [2, 4, 6, 8, 10]
```

### `each...reduce` — acumulador (fold)

Acumula um resultado iterando sobre uma coleção. Equivale a um `fold`/`reduce` funcional.

```u
// Sintaxe: each item in coleção reduce acc: valorInicial { corpo }
soma: each n in [1, 2, 3, 4, 5] reduce acc: 0 { acc + n }
// soma = 15
```

Exemplo com estruturas complexas — insertion sort que acumula o array ordenado:

```u
ordenar: [arr] {
    each j in 1..4 reduce acc: arr {
        descer[acc, j]
    }
}
```

---

## 10. Funções (Closures)

### Definição e invocação

Funções são closures de primeira classe. Parâmetros usam `[]`, corpo usa `{}`. O último valor computado é o retorno automático.

```u
// Definição
dobrar: [n] { n * 2 }

// Invocação
resultado: dobrar[21]   // 42
```

### Múltiplos parâmetros

```u
somar: [a, b] { a + b }
resultado: somar[10, 5]   // 15

// Exemplo real: get/set funcional em array-como-mapa
get: [i, arr] {
    match i {
        0: arr.v0
        1: arr.v1
        _: arr.v2
    }
}
val: get[1, meu_array]
```

### Recursão

U não tem loops imperativos; recursão com block arms é o padrão para algoritmos.

```u
fatorial: [n] {
    match n {
        0: 1
        _: n * fatorial[n - 1]
    }
}

fatorial[10] -> out   // 3628800
```

```u
fibonacci: [n] {
    match n {
        0: 0
        1: 1
        _: fibonacci[n - 1] + fibonacci[n - 2]
    }
}
```

### Funções como valores

```u
aplicar: [f, x] { f[x] }
resultado: aplicar[dobrar, 21]   // 42
```

### Funções matemáticas embutidas

```u
floor[3.7]    // 3
ceil[3.2]     // 4
round[3.5]    // 4
abs[-5]       // 5
sqrt[16]      // 4
number["42"]  // 42
```

---

## 11. Sistema de Tipos (`is`, `as`)

### Verificação de tipo

```u
valido: 42 is Number        // true
texto: "oi" is String       // true
nulo: null is Null          // true
```

### Conversão de tipo

```u
texto_idade: 30 as String   // "30"
num: "42" as Number         // 42
```

---

## 12. Assincronismo (`async`/`await`)

Funções assíncronas são marcadas com o modificador `[async]`. `await` suspende a execução até a resolução.

```u
buscarPerfil: [async] [id] {
    dados: await fetch[id]
    dados
}

perfil: await buscarPerfil["user-123"]
perfil.nome -> out
```

`await` pode ser usado diretamente em qualquer expressão de invocação de função assíncrona.

---

## 13. Diretivas de Agente IA

A principal inovação de U: funções sem corpo lógico delegam a computação a um agente LLM via IPC nativo. O runtime pausa, emite um JSON para o processo hospedeiro (agente) e retoma com a resposta.

### Definição de diretiva

```u
// Sem corpo { } — o runtime delega ao agente
resumir: [texto] [prompt: "Faça um resumo de 2 frases em português"]
```

### Invocação assíncrona

```u
resultado: await resumir["Este artigo fala sobre compiladores..."]
resultado -> out
```

### Exemplo completo

```u
{%
  Simulação financeira delegada a um agente LLM
%}

"Digite a taxa Selic anual (ex: 10.5):" -> out
taxa_selic <- in

projetarRendimento: [taxa] [prompt: "Calcule juros compostos para R$ 10.000 em 5 anos usando essa taxa. Retorne APENAS o número final."]

"Processando via IA..." -> out
resultado: await projetarRendimento[taxa_selic]

"Rendimento em 5 anos: {resultado}" -> out
```

### Protocolo IPC

Quando o runtime encontra `await fn[args]` em uma função com diretiva, emite via stdout:

```json
{
  "type": "agent_directive",
  "function": "projetarRendimento",
  "prompt": "Calcule juros compostos...",
  "input": "10.5"
}
```

O agente hospedeiro responde via stdin com o valor a ser retomado.

---

## 14. Módulos

### Declaração

```u
module Matematica
```

### Exportação e importação

```u
// Em matematica.u
module Matematica

somar: [a, b] { a + b }
```

```u
// Em outro arquivo
use somar from Matematica

resultado: somar[3, 4]
```

---

## Exemplos de Referência

| Arquivo              | Conceitos demonstrados                                      |
|----------------------|-------------------------------------------------------------|
| `hello.u`            | Atribuição, each, comprehension, closure, diretiva          |
| `math.u`             | Recursão, match, fatorial, fibonacci                        |
| `busca_binaria.u`    | List literal, `arr[i]`, `div`, `when` guards, block arm     |
| `insertion_sort.u`   | Multi-param, `and` curto-circuito, `reduce`, block arm      |
| `mergesort.u`        | `and` para terminação, `when` para seleção, `div`           |
| `quicksort.u`        | Block arm em recursão, mapa funcional como array            |
| `dijkstra.u`         | `{obj.prop}` em interpolação, block arm, multi-param        |
| `kruskal.u`          | Union-Find funcional, multi-param                           |
| `euclides.u`         | MDC recursivo, retorno de mapa, interpolação                |
| `agent.u`            | `<- in`, diretiva de agente, `await`                        |
