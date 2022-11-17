import { useDispatch, useSelector } from "react-redux";
import {
  listSelector,
  deleteTodo,
  toggleTaskStatus,
} from "../state/todos/todosSlice";

export function List() {
  const todos = useSelector(listSelector);
  const dispatch = useDispatch();

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
                    dispatch(deleteTodo(todo.id));
                  }}
                >
                  Remove ✘
                </button>
                <button
                  className="mark-as-done-button"
                  onClick={() => {
                    dispatch(toggleTaskStatus(todo));
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
