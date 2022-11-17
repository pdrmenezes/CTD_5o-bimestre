import { createSlice } from '@reduxjs/toolkit'

const todosSlice = createSlice({
  name: "todos",
  initialState: {
    list: [],
  },
  reducers: {
    setTodos(state, action) {
      state.list = action.payload
    },
    addTodo: (state, action) => {
      state.list.push(action.payload)
    },
    removeTodo(state, action) {
      state.list = state.list.filter((todo) => todo.id !== action.payload)
    },
    toggleTodo(state, action) {
      state.list.map((todo) => todo.id === action.payload ? todo.completed = !todo.completed : todo)
    }
  }
})

export function fetchTodos() {
  return async (dispatch, getState) => {
    const response = await fetch('http://localhost:3001/todos')
    const data = await response.json()

    dispatch(setTodos(data))
  }
}

export function deleteTodo(todoId) {
  return async (dispatch) => {
    await fetch(`http://localhost:3001/todos/${todoId}`, { method: 'DELETE' })

    dispatch(removeTodo(todoId))
  }
}

export function toggleTaskStatus(todo) {
  return async (dispatch) => {
    await fetch(`http://localhost:3001/todos/${todo.id}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ ...todo, completed: !todo.completed })
    })
    dispatch(toggleTodo(todo.id))
  }
}

export function createTodo(text) {
  return async (dispatch) => {
    const response = await fetch(`http://localhost:3001/todos`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ text, completed: false })
    })
    const createdTodo = await response.json()

    dispatch(addTodo(createdTodo))
  }
}

export const listSelector = (state) => state.todos.list
export const { setTodos, addTodo, removeTodo, toggleTodo } = todosSlice.actions
export default todosSlice.reducer