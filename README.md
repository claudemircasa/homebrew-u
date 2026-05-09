# Universal Abstract Language (U) - Manual da Linguagem

```text
    []---------[]       []---------[]     u-shell ~ version 1.1.0 (Governor)
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


A **Universal Abstract Language (U)** é uma linguagem de programação moderna focada em AI-First, Pipelines Funcionais e "Coleções como Contextos". Ela foi projetada para ser extremamente limpa e expressiva, abolindo as verbosidades de linguagens tradicionais. 

**Regras de Ouro da Linguagem U:**
- **Sem parênteses:** Funções usam `[]` em vez de `()`.
- **Sem if/else e for/while:** Controle de fluxo é feito com `match`, `guard` e `each/yield`.
- **Coleções são Contextos:** Objetos e dicionários são tratados como contextos encapsulados.
- **Ponto-e-vírgula Opcional:** O caractere `;` pode ser usado para separar expressões na mesma linha, mas não é obrigatório no fim de declarações.
- **AI-First:** Funções podem não ter corpo lógico, terceirizando o trabalho nativamente para um Agente LLM via diretivas.

---

## ⚙️ Instalação e Execução

Os arquivos da linguagem U utilizam a extensão **`.u`**.

### Instalação no macOS via Homebrew (Recomendado)
Para usuários de Mac, a instalação oficial via Homebrew já está disponível:
```bash
brew install claudemircasa/u/u
```

### Instalação via Cargo / Código-fonte
Para compilar e rodar o projeto do zero, é necessário o ecossistema do [Rust e Cargo](https://rustup.rs/).

```bash
cargo run --release script.u
```

Ou usando o binário executável diretamente:
```bash
./target/release/universal-abstract-language script.u
```

---

## 📖 Guia de Sintaxe e Funcionalidades

### 1. Tipos e Literais Primitivos

U possui quatro tipos primários fundamentais:
```aml
// Numbers (Números fluantes por padrão)
idade: 25
preco: 19.99

// Strings
nome: "Alice"
mensagem: "Olá {nome}, bem-vinda!" // Interpolação nativa

// Booleans
ativo: true
deletado: false

// Null (Ausência de valor)
vazio: null
```

### 2. Atribuição e Sinks/Sources de Fluxo (`<-`, `->`, `out`, `in`)

Esqueça o sinal de igual `=` para atribuição primária. Em U, os dados fluem em uma direção clara apontada pelas setas:

```aml
// O fluxo vai da direita para a esquerda:
usuario <- "Maria"
idade: 30 // 'dois pontos' é usado para declarações literais (sugar syntax)

// O fluxo vai da esquerda para a direita (Sink para Output Padrão):
"Iniciando o sistema..." -> out
usuario -> out

// Captura de Entrada do Usuário (Source do Input Padrão):
"Qual o seu nome?" -> out
nome <- in
"Olá {nome}!" -> out
```

### 3. Operadores Matemáticos, Lógicos e Relacionais

Os operadores clássicos estão presentes, com adições pontuais modernas.

**Matemáticos:**
```aml
soma: 10 + 5
sub: 10 - 5
mult: 10 * 5
div: 10 / 5
mod: 10 % 3
potencia: 2 ** 3
```

**Lógicos e Relacionais:**
As palavras chave `and`, `or` e `not` substituem os cripticos `&&`, `||`, `!`.
```aml
// Retorna booleanos
maior: 10 > 5
menor: 10 <= 20
igual: 10 == 10
diferente: 10 != 5

// Lógicos
aprovado: nota > 7 and presenca >= 75
reprovado: nota < 5 or presenca < 75
valido: not falso
```

### 4. Tratamento de Nulos e Conversões Semânticas (`??`, `?.`, `is`, `as`)

Não precisamos de Try/Catch manuais para fluxos de dados, a linguagem foca em Null-Safety:

```aml
// Optional Chaining (Não explode se `endereco` for Null)
rua: usuario.endereco?.rua

// Null Coalescing (Fallback)
// Se `idade` for null, usa `18`
idade_final: idade ?? 18

// Type Checking Dinâmico
valido: idade_final is Number
texto_idade: idade_final as String
```

### 5. Controle de Fluxo: `guard` e `match`

U não possui blocos `if/else`. Favorecemos o *Early-Return* explícito com o `guard` e o Pattern Matching estrutural com o `match`.

**Guard (Proteja o fluxo ou retorne prematuramente):**
```aml
guard usuario.autenticado else "Usuário Deslogado" -> out
```

**Match (Substitui If/Else e Switch-Case):**
O *underscore* `_` representa o estado padrão (default).
```aml
status: 404

match status {
    200: "Sucesso!" -> out
    404: "Não Encontrado." -> out
    _: "Erro Desconhecido." -> out
}
```

### 6. Estruturas de Dados e Manipulação (Listas, Mapas e Spread)

Estruturas complexas são criadas nativamente utilizando colchetes para Listas e Chaves para Mapas/Dicionários.

```aml
// Listas Base
numeros: [1, 2, 3]

// Spread Operator (...) "Achata" uma lista dentro de outra
novos_numeros: [0, ...numeros, 4, 5]

// Mapas Dinâmicos (Dicionários)
cliente: { id: 100, nome: "Jhon", plano: "Premium" }

// Acesso a propriedades
cliente.nome -> out
```

### 7. Repetições Funcionais: `each` e `yield`

Não use laços infinitos que não geram dados, use *Comprehensions* e *Ranges* matemáticos.

```aml
// Range simples '..', itera sem gerar retorno
each n in 1..3 {
    n -> out
}

// Filtro e Construção de Lista simultâneo
pares: each num in 1..10 when num % 2 == 0 yield num * 10
pares -> out // Saída: [20, 40, 60, 80, 100]
```

### 8. Closures e Funções Puras

Todas as funções (Closures) utilizam colchetes `[]` tanto na declaração de parâmetros quanto na hora de invocar, eliminando a ambiguidade visual de parênteses `()`.

```aml
// Definição da função (o último valor computado é o retorno automático)
somar: [a, b] { 
    a + b 
}

// Invocação da Função (Sem parênteses!)
resultado: somar[10, 5]
```

### 9. Paradigma Meta e Instanciação de Contexto

Uma função em U (`NodeDef`) pode agir como uma classe para instanciar blocos de memória ou "Universos" de propriedades.

```aml
// Blueprint
Veiculo[detalhes] {
    tipo: "Transporte"
}

// Instanciando
carro_esportivo [Veiculo] {
    velocidade: 300
    marca: "Ferrari"
}

// O bloco 'carro_esportivo' age como um dicionário nativo e auto-executável:
carro_esportivo.velocidade -> out
```

### 10. Assincronismo Nativo (`[async]` e `await`)

A linguagem U suporta computação assíncrona. Use o modificador sintático `[async]` dentro da array de diretivas de uma função para promovê-la.

```aml
// Função nativamente assíncrona
buscarUsuario: [async] [id] {
    // Await pausa o bloco esperando a promise ser resolvida
    perfil: await fetch[id]
    perfil -> out
}
```

### 11. AI-First: Diretivas de Agente LLM

Essa é a grande revolução da linguagem U. Você não escreve o código lógico, você define **Diretivas** para delegar a computação a um agente LLM integrado. O runtime executa isso nativamente.

Se um *Closure* possuir a diretiva `[prompt: "..."]` mas não declarar o bloco de execução lógico `{ ... }`, ele se transforma num **Agent Delegate**.

```aml
// Declara a função e o que ela faz textualmente:
summarizeText: [text] [prompt: "Return a 2-sentence summary in Portuguese"]

// Chama a função assincronamente e deixa a magia acontecer:
resumo: await summarizeText["This is a very long article about the history of compilers..."]
resumo -> out
```

---

O Compilador Universal Abstract Language está vivo e aguardando suas diretrizes! 
Para ver as especificações arquiteturais internas ou protocolos de linguagem (`aml.md`), verifique os diretórios de Tasks e o arquivo de especificações da governança original.
