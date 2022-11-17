import React from "react";
import { Link } from "react-router-dom";
import pokebola from "../../assets/pokebola.png";
import treinador from "../../assets/treinador.png";
import pikachu from "../../assets/pikachu.png";
import Input from "../Input";
import Detalhe from "./detalhe";
import { useFormContext } from "../../context/FormContext";

// Neste componente temos nosso formulário e dentro dele
// temos os componentes que precisam consumir nosso estado.
// Lembre-se qual é o passo que devemos dar para que nosso
// componentes podem consumir um estado global.

const Formulario = () => {
  const { state, dispatch } = useFormContext();
  return (
    <>
      <header className="form-header">
        <div>
          <img src={pokebola} alt="pokebola" />
          <h2>Centro Pokémon de Ash</h2>
        </div>
        <Link className="retorna" to="/">
          Inicio
        </Link>
      </header>
      <div className="formulario-entrada">
        <h3>Solicitação de atenção</h3>
        <p>
          Por favor, preencha o formulário para que possamos mostrar seu Pokémon
        </p>
        <div className="corpo-formulario">
          <div className="inputs">
            <div>
              <p className="nome-secao">
                <img src={treinador} alt="treinador" />
                <span>Treinador</span>
              </p>
              <Input
                name="nome"
                label="Nome"
                value={state.trainer.name}
                onChange={(value) =>
                  dispatch({
                    type: "UPDATE_TRAINER",
                    payload: { value, field: "name" },
                  })
                }
              />
              <Input
                name="sobrenome"
                label="Sobrenome"
                value={state.trainer.lastName}
                onChange={(value) =>
                  dispatch({
                    type: "UPDATE_TRAINER",
                    payload: { value, field: "lastName" },
                  })
                }
              />
              <Input
                name="email"
                label="Email"
                type="email"
                value={state.trainer.email}
                onChange={(value) =>
                  dispatch({
                    type: "UPDATE_TRAINER",
                    payload: { value, field: "email" },
                  })
                }
              />
            </div>
            <div>
              <p className="nome-secao">
                <img src={pikachu} alt="pikachu" />
                <span>Pokémon</span>
              </p>
              <Input
                name="nomePokemon"
                label="Nome"
                type="text"
                value={state.pokemon.name}
                onChange={(value) =>
                  dispatch({
                    type: "UPDATE_POKEMON",
                    payload: {
                      value,
                      field: "name",
                    },
                  })
                }
              />
              <Input
                name="tipoPokemon"
                label="Tipo"
                type="text"
                value={state.pokemon.type}
                onChange={(value) =>
                  dispatch({
                    type: "UPDATE_POKEMON",
                    payload: {
                      value,
                      field: "type",
                    },
                  })
                }
              />
              <Input
                name="alturaPokemon"
                label="Altura"
                type="number"
                value={state.pokemon.height}
                onChange={(value) =>
                  dispatch({
                    type: "UPDATE_POKEMON",
                    payload: {
                      value,
                      field: "height",
                    },
                  })
                }
              />
              <Input
                name="idadePokemon"
                label="Idade"
                type="text"
                value={state.pokemon.age}
                onChange={(value) =>
                  dispatch({
                    type: "UPDATE_POKEMON",
                    payload: {
                      value,
                      field: "age",
                    },
                  })
                }
              />
            </div>
          </div>
          <Detalhe />
        </div>
      </div>
    </>
  );
};

export default Formulario;
