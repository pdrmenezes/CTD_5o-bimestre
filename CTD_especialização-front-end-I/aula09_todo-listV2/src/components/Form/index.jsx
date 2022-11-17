import { useTodos } from "contexts/todosContext";
import { useRef } from "react";
import { useMutation } from "react-query";
import { createTodo } from "services/createTodo";

function Form() {
  const inputRef = useRef(null);
  const { add } = useTodos();

  const mutation = useMutation(createTodo, {
    onSuccess(data) {
      add(data);
    },
    onError(error) {
      alert("Something went wrong: " + error.message);
    },
  });

  function onSubmit(event) {
    event.preventDefault();

    const title = inputRef.current.value;
    inputRef.current.value = "";

    mutation.mutate({ title, completed: false });
  }

  return (
    <form onSubmit={onSubmit}>
      <input
        ref={inputRef}
        placeholder={
          mutation.isLoading ? "Creating todo..." : "Type your task title"
        }
      />
    </form>
  );
}

export default Form;
