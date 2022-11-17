import "./App.css";
import { fetchAvailableProducts, isLoadingSelector } from "./state/cart";
import { useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { ProductList } from "./components/ProductList";

function App() {
  const isLoading = useSelector(isLoadingSelector);
  const dispatch = useDispatch();

  useEffect(() => {
    dispatch(fetchAvailableProducts());
  }, [dispatch]);

  return (
    <main>
      <h1>Loja Supimpa</h1>
      {isLoading ? <p>carregando...</p> : <ProductList />}
    </main>
  );
}

export default App;
