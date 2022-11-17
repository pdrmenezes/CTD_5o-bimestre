import { ReactElement } from "react";
import { setCurrentPage, Pages } from "../../state/router";
import { useAppDispatch } from "../../state/hooks";

export function Header(): ReactElement {
  const dispatch = useAppDispatch();

  function onClickPageButton(page: Pages) {
    dispatch(setCurrentPage(page));
  }

  return (
    <header>
      <button onClick={() => onClickPageButton(Pages.LIST)}>LIST</button>
      <button onClick={() => onClickPageButton(Pages.FAVORITES)}>
        FAVORITES
      </button>
      <button onClick={() => onClickPageButton(Pages.EPISODES)}>
        FAVORITES
      </button>
    </header>
  );
}
