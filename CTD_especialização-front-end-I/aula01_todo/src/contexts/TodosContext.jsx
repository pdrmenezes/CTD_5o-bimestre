import { createContext, useState, useContext } from "react";

const TodosContext = createContext();

export function useTodosContext() {
  const todosData = useContext(TodosContext);

  if (!todosData) {
    throw Error("O componente precisa estar dentro do provider");
  }
  return todosData;
}

export function TodosContextProvider({ children }) {
  const [tasks, setTasks] = useState([]);

  const addTask = (taskTitle) => {
    const newTask = {
      id: tasks.length + 1,
      title: taskTitle,
    };

    setTasks([...tasks, newTask]);
  };

  const removeTask = (taskToRemove) => {
    const newTasks = tasks.filter((task) => {
      return task.id !== taskToRemove.id;
    });
    setTasks(newTasks);
  };

  return (
    <TodosContext.Provider value={{ tasks, addTask, removeTask }}>
      {children}
    </TodosContext.Provider>
  );
}
