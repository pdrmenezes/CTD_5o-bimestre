import { ReactElement } from "react";
import "./App.css";
import Pokemon from "./Pokemon";
import { pokemons } from "./pokemons";

// evitar usar o tipo React.FC pra tipar componentes e dar preferência ao ReactElement
function App(): ReactElement {
  return (
    <div className="App">
      <header>
        <h1>React App With Vite & Typescript</h1>
      </header>
      <Pokemon pokemonList={pokemons} />
    </div>
  );
}

export default App;
