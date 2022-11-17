import React, { useState, useContext } from "react";
import { ContextoFormulario } from "../../context/contextoFormulario";
import { useQuery } from "react-query";

export const getEspecies = async () => {
  const data = await fetch("https://pokeapi.co/api/v2/pokemon-species/")
    .then((res) => res.json())
    .catch((error) => console.error(error));
  console.log(data);
  return data;
};

const InputEspecie = ({ name, label }) => {
  const [mostrarPopup, setMostrarPopup] = useState(false);
  const { handleInputBlur } = useContext(ContextoFormulario);
  const { isLoading, isError, data, isSuccess } = useQuery(["especies"], () =>
    getEspecies()
  );

  const handleNextPage = (url) => {};

  const escolherEspecie = (e, nomeEspecie) => {
    e.preventDefault();

    handleInputBlur("ATUALIZAR_POKEMON", {
      campo: "especiePokemon",
      valor: nomeEspecie,
    });
    setMostrarPopup(false);
  };

  const renderizarEspecies = (data) => (
    <>
      {data.results.map((especie) => (
        <button
          key={especie.name}
          className="botoes-especie"
          onClick={(e) => escolherEspecie(e, especie.name)}
        >
          {especie.name}
        </button>
      ))}
    </>
  );

  return (
    <div className="input-receptor">
      {mostrarPopup && (
        <div className="popup-especie">
          <h4>Selecionar espécie</h4>
          <div className="receptor-especies">{renderizarEspecies(data)}</div>
          <div className="paginacao">
            {data.previous && (
              <button className="botao-anterior">Anterior</button>
            )}
            {data.next && <button className="botao-seguinte">Seguinte</button>}
          </div>
        </div>
      )}
      <p htmlFor={name}>{label}</p>
      <button
        className="botao-selecionar-especies"
        onClick={() => setMostrarPopup(true)}
      >
        Selecionar
      </button>
    </div>
  );
};

export default InputEspecie;
