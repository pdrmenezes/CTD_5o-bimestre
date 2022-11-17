import { useEffect } from "react";
import { useDispatch } from "react-redux";
import { fetchTodos } from "./state/todos/todosSlice";

import { Form } from "./components/Form";
import { List } from "./components/List";
import "./App.css";

function App() {
  const dispatch = useDispatch();
  useEffect(() => {
    dispatch(fetchTodos());
  }, []);
  return (
    <div className="App">
      <h1 style={{ textAlign: "center" }}>React + Redux + Thunk</h1>
      <Form />
      <List />
    </div>
  );
}

export default App;
