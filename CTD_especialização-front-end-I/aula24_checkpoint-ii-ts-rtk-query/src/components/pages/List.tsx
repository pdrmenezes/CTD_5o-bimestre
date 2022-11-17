import { ReactElement, useEffect } from "react";
import { useAppDispatch, useAppSelector } from "../../state/hooks";
import { Character } from "../character";

export function List(): ReactElement {
  const list = useAppSelector((state) => state.characters.list);

  return (
    <>
      <h1>CHARACTERS LIST</h1>
      <div id="list">
        {list.map((character) => (
          <Character key={character.id} character={character} />
        ))}
      </div>
    </>
  );
}
