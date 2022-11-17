import { configureStore } from "@reduxjs/toolkit";
import charactersReducer from "./characters";
import routerReducer from "./router";
import { rickAndMortyApi } from "./episodes/episodes";

export const store = configureStore({
  reducer: {
    characters: charactersReducer,
    router: routerReducer,
    [rickAndMortyApi.reducerPath]: rickAndMortyApi.reducer,
  },
});

// Infer the `RootState` and `AppDispatch` types from the store itself
export type RootState = ReturnType<typeof store.getState>;
// Inferred type: {posts: PostsState, comments: CommentsState, users: UsersState}
export type AppDispatch = typeof store.dispatch;
