import { configureStore } from '@reduxjs/toolkit'
import { reducer as todosReducer } from './todos/reducer'

export default configureStore({
  reducer: {
    todos: todosReducer
  },
})
