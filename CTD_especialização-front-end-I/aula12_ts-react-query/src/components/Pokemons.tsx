import { IPokemon } from "../types";
import { useQuery } from "react-query";

export const getPokemons = async () => {
  try {
    const res = await fetch(
      `https://pokeapi.co/api/v2/pokemon?limit=20&offset=50`
    );
    return res.json();
  } catch (error) {
    console.error(error);
    throw error;
  }
};

export default function Pokemon() {
  const { isLoading, isError, data } = useQuery(["pokemons"], () =>
    getPokemons()
  );

  if (isLoading) return <p>Carregando dados...</p>;
  if (isError) return <p>Erro ao carregar dados. Tente novamente</p>;

  return (
    <div>
      {data.results.map((pokemon: IPokemon) => {
        return (
          <div key={pokemon.name}>
            <p>Nome: {pokemon.name}</p>
          </div>
        );
      })}
    </div>
  );
}
