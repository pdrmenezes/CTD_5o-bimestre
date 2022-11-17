import { useDispatch, useSelector } from "react-redux";
import { deleteTodo, toggleTodo } from "../state/todos/actions";
import { todosSelector } from "../state/todos/selectors";

export function List() {
  const todos = useSelector(todosSelector);
  const dispatch = useDispatch();

  const handleDelete = (id) => {
    dispatch(deleteTodo(id));
  };

  const handleToggle = (id) => {
    dispatch(toggleTodo(id));
  };

  return (
    <div id="list">
      <ul style={{ listStyle: "none" }}>
        {todos.map((todo) => {
          return (
            <li key={`${todo.text}-${todo.id}`}>
              <h3>
                {todo.text} {todo.completed && "✅"}
              </h3>
              <div>
                <button
                  className="remove-button"
                  onClick={() => {
                    handleDelete(todo.id);
                  }}
                >
                  Remove ✘
                </button>
                <button
                  className="mark-as-done-button"
                  onClick={() => {
                    handleToggle(todo.id);
                  }}
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
