import { call, put, takeLatest, takeEvery } from "@redux-saga/core/effects";
import { addProduct, setAvailableProducts, setIsLoading } from "../cart";

function* fetchProducts() {
  yield put(setIsLoading(true))

  const response = yield call(fetch, "https://fakestoreapi.com/products", {
    headers: {
      'Content-Type': 'application/json'
    }
  })

  const data = yield response.json()
  yield put(setAvailableProducts(data))

  yield put(setIsLoading(false))
}

function* addProductToCart(product) {
  yield put(addProduct(product))

  const response = yield call(fetch, "https://fakestoreapi.com/products", {
    method: "POST",
    body: JSON.stringify(product)
  })

  const data = yield response.json()

  console.log(data);
  console.log(product);

  yield put(setIsLoading(false))
}

export default function* rootSagas() {
  yield takeLatest("store/fetchAvailableProducts", fetchProducts)
  yield takeEvery("store/addProductToCartStateAndApi", addProductToCart)
}