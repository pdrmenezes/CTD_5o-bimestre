

export async function createTodo(todo) {
  const response = await fetch('http://localhost:3010/todos', {
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    method: 'POST',
    body: JSON.stringify(todo)
  });

  return response.json();
}