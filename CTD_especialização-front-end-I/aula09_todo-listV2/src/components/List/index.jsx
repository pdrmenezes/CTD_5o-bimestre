import { useTodos } from "contexts/todosContext";
import { useQuery, useMutation } from "react-query";
import { listTodos } from "services/listTodos";
import { deleteTodo } from "services/deleteTodo";
import { completeTodo } from "services/completeTodo";

function List() {
  const { todos, remove, markAsCompleted, setTodos } = useTodos();

  useQuery("todos", listTodos, {
    onSuccess: (data) => setTodos(data),
    refetchOnWindowFocus: false,
  });

  const deleteTodoMutation = useMutation(deleteTodo, {
    onSuccess(_, todoId) {
      remove(todoId);
    },
  });

  const completeTodoMutation = useMutation(completeTodo, {
    onSuccess(_, todoId) {
      markAsCompleted(todoId);
    },
  });

  return (
    <div id="list">
      <ul>
        {todos.map((todo) => {
          return (
            <li key={`${todo.title}-${todo.id}`}>
              <h1>
                {todo.title} {todo.completed && "✅"}
              </h1>
              <div>
                <button
                  className="remove-button"
                  onClick={() => deleteTodoMutation.mutate(todo.id)}
                >
                  Remove ✘
                </button>
                <button
                  className="mark-as-done-button"
                  onClick={() => completeTodoMutation.mutate(todo.id)}
                >
                  Done ✔
                </button>
              </div>
            </li>
          );
        })}
      </ul>
    </div>
  );
}

export default List;
