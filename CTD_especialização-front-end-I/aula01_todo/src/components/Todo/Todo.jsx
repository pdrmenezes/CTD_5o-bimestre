import { useTodosContext } from "../../contexts/TodosContext";

export default function Todo({ task }) {
  const { removeTask } = useTodosContext();
  return (
    <div key={task.id}>
      <p>Task id: {task.id}</p>
      <p>Task Title: {task.title}</p>
      <button onClick={() => removeTask(task)}>Remover</button>
    </div>
  );
}
