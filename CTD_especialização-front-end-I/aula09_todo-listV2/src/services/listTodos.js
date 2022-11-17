

export async function listTodos() {
  const response = await fetch('http://localhost:3010/todos', {
    headers: {
      'Accept': 'application/json'
    }
  });

  return response.json();
}