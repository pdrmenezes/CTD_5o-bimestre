import reactLogo from "./assets/react.svg";
import "./App.css";
import { useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import {
  cartSelector,
  fetchProducts,
  submitOrder,
} from "./state/cart/cartSlice";

function App() {
  const dispatch = useDispatch();
  const products = useSelector(cartSelector);
  console.log(products);

  useEffect(() => {
    dispatch(fetchProducts());
  }, []);

  return (
    <div className="App">
      <div>
        <a href="https://vitejs.dev" target="_blank">
          <img src="/vite.svg" className="logo" alt="Vite logo" />
        </a>
        <a href="https://reactjs.org" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Vite + React</h1>
      {products.map((product) => {
        return (
          <div key={product.id}>
            <h3>{product.name}</h3>
            <p>${product.price}</p>
            <button>➕</button>
            <button>🗑</button>
          </div>
        );
      })}
      <div className="card">
        <p>product count is {products.length}</p>
        <button
          onClick={() => {
            dispatch(submitOrder(products));
          }}
        >
          submit order
        </button>
      </div>
    </div>
  );
}

export default App;
