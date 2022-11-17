import Form from "./Form";
import List from "./List";
import { TodosProvider } from "contexts/todosContext";

function App() {
  
  return (
    <div className="App">
      <TodosProvider>
        <Form />
        <List />
      </TodosProvider>
    </div>
  );
}

export default App;
