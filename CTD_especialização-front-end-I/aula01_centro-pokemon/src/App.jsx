import { Routes, Route } from "react-router-dom";
import Inicio from "./components/Inicio";
import Formulario from "./components/Formulario";
import { FormContextProvider } from "./context/FormContext";
import "./App.css";

function App() {
  return (
    <div className="App">
      <Routes>
        <Route path="/" exact element={<Inicio />} />
        <Route
          path="/formularioEntrada"
          element={
            <FormContextProvider>
              <Formulario />
            </FormContextProvider>
          }
        />
      </Routes>
    </div>
  );
}

export default App;
