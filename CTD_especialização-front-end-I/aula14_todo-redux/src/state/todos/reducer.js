import { ACTION_TYPES } from "./actionTypes";

const INITIAL_STATE = {
  todos: []
}

export function reducer(state = INITIAL_STATE, action) {
  switch (action.type) {
    case ACTION_TYPES.ADD_TODO:
      console.log(action)
      return {
        ...state,
        todos: [
          ...state.todos,
          {
            id: Date.now(),
            text: action.payload.text,
            completed: false
          }
        ]
      }
    case ACTION_TYPES.TOGGLE_TODO:
      console.log(action);
      return {
        ...state,
        todos: state.todos.map(todo => todo.id === action.payload.id ? {
          ...todo,
          completed: !todo.completed
        } : todo)
      }
    case ACTION_TYPES.DELETE_TODO:
      console.log(action);
      return {
        ...state,
        todos: state.todos.filter(todo => todo.id !== action.payload.id)
      }
    default:
      return state;
  }
}