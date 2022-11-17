import { createContext, useReducer, useContext } from "react";
import PropTypes from "prop-types";

const FormContext = createContext();

export function useFormContext() {
  const formData = useContext(FormContext);
  if (!formData) {
    throw new Error(
      "Para consumir o estado do provider FormContextProvider é necessário que ele seja filho do provider"
    );
  }
  return formData;
}

/* 
useReducer
  1. initial state fora do componente como objeto com os estados iniciais
  2. função reducer fora do componente que recebe 'state' e 'action como parâmetros' "function reducer(state, action)"
  3. useReducer dentro do componente "const [state, dispatch] = useReducer(reducer, initialState)"
 */

const initialState = {
  trainer: {
    name: "",
    lastName: "",
    email: "",
  },
  pokemon: {
    name: "",
    type: "",
    height: 0,
    age: "",
  },
};

function reducer(state, action) {
  switch (action.type) {
    case "UPDATE_TRAINER":
      return {
        ...state,
        trainer: {
          ...state.trainer,
          [action.payload.field]: action.payload.value,
        },
      };
    case "UPDATE_POKEMON":
      return {
        ...state,
        pokemon: {
          ...state.pokemon,
          [action.payload.field]: action.payload.value,
        },
      };
    default:
      return state;
  }
}

export function FormContextProvider({ children }) {
  const [state, dispatch] = useReducer(reducer, initialState);

  return (
    <FormContext.Provider value={{ state, dispatch }}>
      {children}
    </FormContext.Provider>
  );
}

FormContextProvider.propTypes = {
  children: PropTypes.object,
};
