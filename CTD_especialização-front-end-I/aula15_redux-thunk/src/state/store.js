import { configureStore } from '@reduxjs/toolkit'
import todosReducer from './todos/todosSlice'

export default configureStore({
  reducer: {
    todos: todosReducer
  },
})
