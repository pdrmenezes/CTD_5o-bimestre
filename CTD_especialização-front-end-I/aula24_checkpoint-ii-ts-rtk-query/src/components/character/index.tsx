import { ReactElement } from "react";
import { ICharacter } from "../../types";
import { addFavorite } from "../../state/characters";
import { useAppDispatch, useAppSelector } from "../../state/hooks";

interface CharacterProps {
  character: ICharacter;
}

export function Character(props: CharacterProps): ReactElement {
  const dispatch = useAppDispatch();
  const favorites = useAppSelector((state) => state.characters.favorites);
  const { character } = props;

  const isFavorite = favorites.find((s) => s.id == character.id) !== undefined;

  function onClickAddFavorite() {
    dispatch(addFavorite(character));
  }

  return (
    <div key={character.id} onClick={onClickAddFavorite}>
      <img src={character.image} height={100} width={100} alt="" />
      <h4>{character.name}</h4>
      <span>Status: {character.status}</span>
    </div>
  );
}
