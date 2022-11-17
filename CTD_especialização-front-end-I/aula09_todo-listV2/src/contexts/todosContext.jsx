import { createContext, useState, useContext, useEffect } from "react";
import { useQuery } from "react-query";
import { listTodos } from "services/listTodos";

const TodosContext = createContext();

export function useTodos() {
  const context = useContext(TodosContext);

  if (!context) {
    throw new Error("useTodos must be used within a TodosProvider");
  }

  return context;
}

export function TodosProvider(props) {
  const [todos, setTodos] = useState([]);

  function add(todo) {
    setTodos([...todos, todo]);
  }

  function remove(todoId) {
    setTodos(todos.filter((t) => t.id !== todoId));
  }

  function markAsCompleted(todoId) {
    setTodos(
      todos.map((t) => {
        if (t.id === todoId) {
          return { ...t, completed: true };
        }

        return t;
      })
    );
  }

  return (
    <TodosContext.Provider
      value={{ add, remove, markAsCompleted, setTodos, todos }}
    >
      {props.children}
    </TodosContext.Provider>
  );
}
