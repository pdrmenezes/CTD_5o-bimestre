import { useRef } from "react";
import { useTodosContext } from "../../contexts/TodosContext";

export default function Form() {
  const titleRef = useRef(null);
  const { addTask } = useTodosContext();

  const onClickAddTask = () => {
    addTask(titleRef.current.value);
    titleRef.current.value = "";
  };

  return (
    <div>
      <input ref={titleRef} placeholder="Nova tarefa"></input>
      <button onClick={onClickAddTask}>➕</button>
    </div>
  );
}
