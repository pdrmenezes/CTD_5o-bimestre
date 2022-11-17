import { ReactElement } from "react";
import { useGetAllEpisodesQuery } from "../../state/episodes/episodes";

export function Episodes(): ReactElement {
  const query = useGetAllEpisodesQuery("");
  return (
    <>
      <h1>Episodes</h1>
      <div>
        {query.isLoading ? "CARREGANDO" : null}
        {query.data?.results.map((episode) => {
          return <div key={episode.id}>{episode.name}</div>;
        })}
      </div>
    </>
  );
}
