import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";
import { IEpisode } from "../../types";

export const rickAndMortyApi = createApi({
  reducerPath: "rickAndMortyApi",
  baseQuery: fetchBaseQuery({
    baseUrl: "https://rickandmortyapi.com/api/episode",
  }),
  endpoints: (builder) => {
    return {
      getAllEpisodes: builder.query<{ results: IEpisode[] }, string>({
        query: () => "episode",
      }),
    };
  },
});

export const { useGetAllEpisodesQuery } = rickAndMortyApi;
