import Character from "./Character";
import { useState } from "react";
import { getCharacters } from "../repositories/getCharacters";
import { useQuery } from "react-query";

const Network = () => {
  const [currentPage, setCurrentPage] = useState(1);
  const { isLoading, isError, data } = useQuery(
    ["characters", currentPage],
    () => getCharacters(currentPage),
    { keepPreviousData: true }
  );

  if (isLoading) return <div>Carregando personagens...</div>;
  if (isError)
    return (
      <div>
        Ops, não pudemos carregar os personagens agora. Tente novamente.
      </div>
    );

  return (
    <div>
      {data?.results?.length
        ? data.results.map((personagem) => (
            <Character
              key={personagem.id}
              imagem={personagem.image}
              nome={personagem.name}
              especie={personagem.species}
            />
          ))
        : null}
      <div>
        {currentPage !== 1 ? (
          <button
            className="floating-button-left"
            onClick={() => setCurrentPage(currentPage - 1)}
          >
            Previous Page
          </button>
        ) : null}
        <button
          className="floating-button-right"
          onClick={() => setCurrentPage(currentPage + 1)}
        >
          Next Page
        </button>
      </div>
    </div>
  );
};

export default Network;
