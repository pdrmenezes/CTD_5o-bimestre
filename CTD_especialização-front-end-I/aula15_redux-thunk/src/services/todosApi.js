export const todosApi = {
  fetchTodos: () => fetch('http://localhost:3001/todos').then((response) => response.json()),
  deleteTodo: (todoId) => fetch(`http://localhost:3001/todos/${todoID}`, { method: DELETE })
}