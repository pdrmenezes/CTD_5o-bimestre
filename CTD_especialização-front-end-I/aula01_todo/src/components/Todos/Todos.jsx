import { useTodosContext } from "../../contexts/TodosContext";
import Todo from "../Todo/Todo";

export default function Todos() {
  const { tasks } = useTodosContext();

  return (
    <div>
      {tasks.map((task) => {
        return <Todo task={task} />;
      })}
    </div>
  );
}
