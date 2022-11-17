import { TodosContextProvider } from './contexts/TodosContext';
import './App.css';
import Form from './components/Form/Form';
import Todos from './components/Todos/Todos';


function App() {

  return (
    <TodosContextProvider>
      <div className="App">
        <header className="App-header">
          Todo App
        </header>
        <main>
          <Form />
          <Todos />
        </main>
      </div >
    </TodosContextProvider>

  )
}

export default App;
