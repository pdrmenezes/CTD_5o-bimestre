

export async function deleteTodo(todoId) {
  const response = await fetch(`http://localhost:3010/todos/${todoId}`, {
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    method: 'DELETE',
  })

  return response.json()
}