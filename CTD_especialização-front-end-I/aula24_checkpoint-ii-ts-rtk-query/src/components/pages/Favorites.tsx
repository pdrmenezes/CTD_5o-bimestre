import { ReactElement } from "react";
import { useAppSelector } from "../../state/hooks";
import { Character } from "../character";

export function Favorites(): ReactElement {
  const favorites = useAppSelector((state) => state.characters.favorites);

  return (
    <div>
      <h1>FAVORITES</h1>
      {favorites.map((favorite) => (
        <Character key={favorite.id} character={favorite} />
      ))}
    </div>
  );
}
