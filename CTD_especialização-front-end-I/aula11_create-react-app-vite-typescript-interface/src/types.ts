export interface IPokemon {
  id: number;
  nome: string;
  peso?: number;
  pokemon: boolean;
  categoria: string;
}

// // se quiser tipar a categoria com tipos específicos:

// // usando type
// export type Categoria = "semente" | "lagarto" | "chama" | "treinador";

// export interface IPokemon {
//   id: number;
//   nome: string;
//   peso?: number;
//   pokemon: boolean;
//   categoria: Categoria;
// }

// // usando enum (mais recomendado por ser mais escalável que a lista de types)
// export enum CategoriaEnum {
//   SEMENTE = "semente",
//   LAGARTO = "lagarto",
//   CHAMA = "chama",
//   TREINADOR = "treinador",
// }

// export interface IPokemon {
//   id: number;
//   nome: string;
//   peso?: number;
//   pokemon: boolean;
//   categoria: CategoriaEnum;
// }
