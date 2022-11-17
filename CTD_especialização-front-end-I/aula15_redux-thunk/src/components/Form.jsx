import { useRef } from "react";
import { useDispatch } from "react-redux";
import { createTodo } from "../state/todos/todosSlice";

export function Form() {
  const inputRef = useRef(null);
  const dispatch = useDispatch();

  function onSubmit(event) {
    event.preventDefault();
    const text = inputRef.current.value;
    inputRef.current.value = "";

    dispatch(createTodo(text));
  }

  return (
    <form onSubmit={onSubmit}>
      <input ref={inputRef} placeholder="Type your task" />
    </form>
  );
}
