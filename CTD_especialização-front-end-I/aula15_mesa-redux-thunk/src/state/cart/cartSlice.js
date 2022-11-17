import { createSlice } from '@reduxjs/toolkit'

const cartSlice = createSlice({
  name: "cart",
  initialState: {
    list: []
  },
  reducers: {
    setProducts(state, action) {
      state.list = action.payload
    },
    addProducts(state, action) {
      state.list.push(action.payload)
    },
    removeProducts(state, action) {
      state.list = state.list.filter((product) => product.id !== action.payload)
    },
    clearCart(state, action) {
      state.list = []
    }
  }
})

export function fetchProducts() {
  return async (dispatch) => {
    const response = await fetch(`http://localhost:3002/list`)
    const data = await response.json()

    dispatch(setProducts(data))
  }
}

export function submitOrder(productList) {
  return async (dispatch, getState) => {
    await fetch(`http://localhost:3002/order`, {
      method: 'POST', headers: {
        'Content-Type': 'application/json'
      }, body: JSON.stringify(productList)
    })
    dispatch(clearCart)
  }
}

export const cartSelector = (state) => state.order.list
export const { setProducts, addProducts, removeProducts, clearCart } = cartSlice.actions
export default cartSlice.reducer