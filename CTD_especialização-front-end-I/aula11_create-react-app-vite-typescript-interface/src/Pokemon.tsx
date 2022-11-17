import { IPokemon } from "./types";

interface PokemonProps {
  pokemonList?: IPokemon[];
}

export default function (props: PokemonProps) {
  return (
    <div>
      <h2>Pokemon</h2>
      {props.pokemonList?.map((pokemon) => {
        return (
          <>
            {pokemon.pokemon && (
              <div key={pokemon.id}>
                <h3>{pokemon.nome.toLocaleUpperCase()}</h3>
                {pokemon.peso && <p>Peso: {pokemon.peso}</p>}
                <p>Categoria: {pokemon.categoria}</p>
              </div>
            )}
          </>
        );
      })}
      <hr></hr>
      <h2>Treinador</h2>
      {props.pokemonList?.map((pokemon) => {
        return (
          <>
            {!pokemon.pokemon && (
              <div key={pokemon.id}>
                <h3>{pokemon.nome.toLocaleUpperCase()}</h3>
                <p>{pokemon.categoria}</p>
              </div>
            )}
          </>
        );
      })}
    </div>
  );
}
