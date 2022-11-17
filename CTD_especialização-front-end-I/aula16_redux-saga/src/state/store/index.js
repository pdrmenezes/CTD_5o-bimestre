import { configureStore } from '@reduxjs/toolkit'
import createSagaMiddleware from 'redux-saga'
import cartReducer from '../cart'
import rootSagas from '../sagas'

const sagaMiddleware = createSagaMiddleware()

export default configureStore({
  reducer: {
    cart: cartReducer
  },
  middleware: (getDefaultMiddleware) => [
    ...getDefaultMiddleware({ thunk: false }),
    sagaMiddleware
  ]
})

sagaMiddleware.run(rootSagas)