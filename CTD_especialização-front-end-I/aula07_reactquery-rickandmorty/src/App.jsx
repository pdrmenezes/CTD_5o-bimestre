import "./styles.css";
import Network from "./components/Network";
import { QueryClient, QueryClientProvider } from "react-query";

const queryClient = new QueryClient();

export default function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <div className="App">
        <h1>Rick and Morty</h1>
        <Network />
      </div>
    </QueryClientProvider>
  );
}
