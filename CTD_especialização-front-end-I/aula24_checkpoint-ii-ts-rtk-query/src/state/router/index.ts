import { createSlice, PayloadAction } from "@reduxjs/toolkit";

export enum Pages {
  LIST = "list",
  FAVORITES = "favorites",
  EPISODES = "episodes",
}

const routersSlice = createSlice({
  name: "router",
  initialState: {
    currentPage: Pages.LIST,
  },
  reducers: {
    setCurrentPage(state, action: PayloadAction<Pages>) {
      state.currentPage = action.payload;
    },
  },
});

export const { setCurrentPage } = routersSlice.actions;
export default routersSlice.reducer;
