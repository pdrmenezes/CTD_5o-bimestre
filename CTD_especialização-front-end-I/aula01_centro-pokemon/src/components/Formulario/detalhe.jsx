import React from "react";
import { useFormContext } from "../../context/FormContext";

const Detalhe = () => {
  const { state } = useFormContext();
  return (
    <div className="detalhe-formulario">
      <div className="cabecalho">
        <h3>Vista prévia da solicitação</h3>
      </div>
      <section className="dados-cliente">
        <h4>Dados do Treinador</h4>
        <div className="lista">
          <p>Nome:{state?.trainer.name}</p>
          <p>Sobrenome:{state.trainer.lastName}</p>
          <p>Email:{state?.trainer.email}</p>
        </div>
      </section>
      <section className="dados-cliente">
        <h4>Dados do Pokémon</h4>
        <div className="lista">
          <p>Nome:{state?.pokemon.name}</p>
          <p>Tipo:{state?.pokemon.type}</p>
          <p>Altura:{state?.pokemon.height}m</p>
          <p>Idade:{state?.pokemon.age}</p>
        </div>
      </section>
      <button
        className="botao-enviar"
        onClick={() => alert("Solicitação enviada :)")}
      >
        Enviar Solicitação
      </button>
    </div>
  );
};

export default Detalhe;
