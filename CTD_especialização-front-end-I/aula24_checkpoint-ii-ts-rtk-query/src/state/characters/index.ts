import { PayloadAction, createSlice } from "@reduxjs/toolkit";
import { ICharacter } from "../../types";
import { AppDispatch } from "../../state/store";

export const charactersSlice = createSlice({
  name: "characters",
  initialState: {
    isLoading: false,
    list: [] as ICharacter[],
    favorites: [] as ICharacter[],
  },
  reducers: {
    setCharaters: (state, action) => {
      state.list = action.payload;
    },
    setIsLoading: (state, action) => {
      state.isLoading = action.payload;
    },
    addFavorite: (state, action: PayloadAction<ICharacter>) => {
      const isFavorite = state.favorites.find((c) => c.id == action.payload.id);
      if (isFavorite) return;
      state.favorites.push(action.payload);
    },
  },
});

export function fetchCharacters() {
  return async (dispatch: AppDispatch) => {
    dispatch(setIsLoading(true));

    const response = await fetch("https://rickandmortyapi.com/api/character");
    const data = await response.json();

    dispatch(setCharaters(data.results));
    dispatch(setIsLoading(false));
  };
}

export const { setCharaters, setIsLoading, addFavorite } =
  charactersSlice.actions;
export default charactersSlice.reducer;
