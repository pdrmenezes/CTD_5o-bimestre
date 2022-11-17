import { ReactElement, useEffect, useState } from "react";

interface Character {
  id: number;
  name: string;
  status: string;
}

async function getCharacters(): Promise<Character[]> {
  const response = await fetch("https://rickandmortyapi.com/api/character");
  const data = await response.json();

  return data.results;
}

export default function RickAndMorty(): ReactElement {
  const [characters, setCharacters] = useState<Character[]>([]);

  useEffect(() => {
    getCharacters().then(setCharacters);
  }, []);

  return (
    <div>
      <h1>Characters</h1>
      {characters.map((character) => {
        return (
          <div key={character.id}>
            <h3>{character.name}</h3>
            <p>{character.status}</p>
          </div>
        );
      })}
    </div>
  );
}
