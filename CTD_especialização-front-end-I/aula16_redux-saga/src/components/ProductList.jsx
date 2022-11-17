import { useDispatch, useSelector } from "react-redux";
import {
  addProductToCartStateAndApi,
  availableProductsSelector,
  removeProduct,
  selectedProductsSelector,
} from "../state/cart";

export function ProductList() {
  const products = useSelector(availableProductsSelector);
  const selectedProducts = useSelector(selectedProductsSelector);
  const dispatch = useDispatch();

  return (
    <div>
      <h2>Produtos</h2>
      <div>
        {products.map((product) => {
          return (
            <div className="product-card" key={product.id}>
              <div className="header">
                <p className="title">{product.title}</p>
                <p>R$ {product.price}</p>
              </div>

              <img
                height={300}
                width={300}
                src={product.image}
                alt={product.title}
              />

              <p>{product.description}</p>

              <div className="actions">
                <button
                  onClick={(product) =>
                    dispatch(addProductToCartStateAndApi(product))
                  }
                >
                  Add to cart
                </button>
                <button onClick={() => dispatch(removeProduct(product))}>
                  Remove from cart
                </button>
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}
