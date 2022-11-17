import "./App.css";
import { QueryClient, QueryClientProvider } from "react-query";
import Pokemons from "./components/Pokemons";

const queryClient = new QueryClient();

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <div className="App">
        <Pokemons />
      </div>
    </QueryClientProvider>
  );
}

export default App;
