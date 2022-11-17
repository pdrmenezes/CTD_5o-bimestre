// em javascript não se tipam variáveis
let username = "pedro";

// em typescript usamos tipagens para melhor escalar nosso código
// Number
// String
// Template String
// Boolean
// Array
// Tuple
// Enum
// Any
// Void
// Never
// Union

// string
let user: string = "pedro";

// boolean
let presente: boolean = true;

// number: todos são armazenados como números de ponto flutuante (com casas decimais) e podem ser decimais, hexadecimais ou octais
let primeiro: number = 123; // number
let segundo: number = 0x37cf; // hexadecimal
let terceiro: number = 0o377; // octal
let quarto: number = 0b11101; // binary

console.log(primeiro); // 123
console.log(segundo); // 14287
console.log(terceiro); // 255
console.log(quarto); // 57

// array: existem duas maneiras de declarar o tipo array
// com colchetes após tipo de dado que o array conterá
let frutas: string[] = ["uva", "laranja", "kiwi"];
// do tipo genérico
let frutas2: Array<string> = ["uva", "laranja", "kiwi"];

// arrays com vários tipos de dados
let values: (string | number)[] = ["uva", 2, "laranja", 3, 4, "banana"];
// ou
let values2: Array<string | number> = ["uva", 2, "laranja", 3, 4, "banana"];

// tuple: pode conter dois valores diferentes de dados
var companyId: number = 1;
var companyName: string = "company";

// juntando em um tuple ficaria:
var company: [number, string] = [1, "company"];

// enum: conjunto de constantes nomeadas, coleção de valores relacionados que podem conter numéricos, strings ou ambos
// enum numérico: armazena strings como números
enum Midias {
  Jornal, // Jornal = 0
  Boletim, // Boletim = 1
  Revista, // Revista = 2
  Livro, // Livro = 3
}

// string enum: oferecem melhor legibilidade em depuração
enum Midias2 {
  Jornal = "JORNAL",
  Boletim = "BOLETIM",
  Revista = "REVISTA",
  Livro = "LIVRO",
}

Midias2.Jornal; // saída: JORNAL
Midias2["Revista"]; // saída: Revista

// enum heterogêneo (contém string e number)
enum Status {
  Active = "Active",
  Inactive = 1,
  Pending,
}

// any: usado para lidar com conteúdo dinâmico que não sabemos o tipo de dado que receberemos
var message: any = "hello world";

// array tipo any
let arr: any[] = ["john", 21, true];
arr.push("smith");
console.log(arr); // saída: ['john', 21, true, 'smith']

// any em variável
let nothing: void = undefined;
let num: void = 1; // erro

// void: usado quando não há dados, exemplo uma função não retornar nenhum valor
function sayHi(): void {
  console.log("hi!");
}

// never: quando se tem certeza que algo nunca acontecerá. exemplo, uma função que não chega ao fim ou sempre lança uma exceção
function throwsError(errorMsg: string): never {
  throw new Error(errorMsg);
}

function continuesProcess(): never {
  while (true) {
    console.log("I'm always up to something that never ends");
  }
}

// union: permite usar mais de um tipo de dado pra uma variável ou parâmetro de função
let code: string | number;
code = 123; // ok
code = "abc"; // ok
code = false; // erro

let speak: void = sayHi();
console.log(speak); // saída: undefined

// exemplo de hook feito com TS
const [count, setCount] = useState<number>(0);

const Counter: FunctionComponent = () => {};

// exemplo de função simples com TS
function sum(a: number, b: number): number {
  return a + b;
}

function subtraction(a: number, b: number): number {
  return a - b;
}

// typescript playground pra visualizar códigos diferentes em TS e familiarizar com estrutura <https://www.typescriptlang.org/>
