

export async function completeTodo(todoId) {
  const response = await fetch(`http://localhost:3010/todos/${todoId}`, {
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    method: 'PATCH',
    body: JSON.stringify({ completed: true })
  })

  return response.json()
}