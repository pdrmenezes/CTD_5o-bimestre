import { useReducer } from "react";

let initialState = { amount: 0, price: 15 };
function reducer(state, action) {
  switch (action.type) {
    case "INCREMENT": {
      return {
        ...state,
        amount: state.amount + 1,
      };
    }
    case "DECREMENT": {
      return {
        ...state,
        amount: state.amount - 1,
      };
    }
    case "RESET": {
      return {
        ...state,
        amount: 0,
      };
    }
    default:
      return state;
  }
}

export default function Contador(props) {
  const [state, dispatch] = useReducer(reducer, initialState);

  return (
    <>
      <h1>Preço total: R$ {state.amount * state.price}</h1>
      <div>
        <button onClick={() => dispatch({ type: "INCREMENT" })}>+</button>
        <button onClick={() => dispatch({ type: "DECREMENT" })}>-</button>
        <button onClick={() => dispatch({ type: "RESET" })}>Reset</button>
      </div>
    </>
  );
}
