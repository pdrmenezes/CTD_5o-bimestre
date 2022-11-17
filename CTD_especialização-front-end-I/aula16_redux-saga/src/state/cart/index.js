import { createSlice } from '@reduxjs/toolkit'

const cartSlice = createSlice({
  name: "cart",
  initialState: {
    isLoading: false,
    availableProducts: [],
    selectedProducts: []
  },
  reducers: {
    addProduct: (state, action) => {
      state.selectedProducts.push(action.payload)
    },
    removeProduct: (state, action) => {
      state.selectedProducts = state.selectedProducts.filter(
        (product) => product.id !== action.payload.id
      )
    },
    setAvailableProducts: (state, action) => {
      state.availableProducts = action.payload
    },
    setIsLoading: (state, action) => {
      state.isLoading = action.payload
    }
  }
})

// SELECTORS
export const isLoadingSelector = (state) => state.cart.isLoading
export const availableProductsSelector = (state) => state.cart.availableProducts
export const selectedProductsSelector = (state) => state.cart.selectedProducts

// ACTION CREATORS
export const fetchAvailableProducts = () => ({ type: "store/fetchAvailableProducts" })
export const addProductToCartStateAndApi = () => ({ type: "store/addProductToCartStateAndApi" })

export const { addProduct, removeProduct, setAvailableProducts, setIsLoading } = cartSlice.actions

// REDUCER
export default cartSlice.reducer