import { ACTION_TYPES } from "./actionTypes"

export function addTodo(text) {
  return {
    type: ACTION_TYPES.ADD_TODO,
    payload: {
      text
    },
  }
}

export function toggleTodo(id) {
  return {
    type: ACTION_TYPES.TOGGLE_TODO,
    payload: {
      id
    }
  }
}

export function deleteTodo(id) {
  return {
    type: ACTION_TYPES.DELETE_TODO,
    payload: {
      id
    }
  }
}

