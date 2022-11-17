import { ReactElement, useEffect } from "react";
import { useAppDispatch, useAppSelector } from "./state/hooks";
import { fetchCharacters } from "./state/characters";
import { List } from "./components/pages/List";
import { Favorites } from "./components/pages/Favorites";
import { Header } from "./components/header";
import { Pages } from "./state/router";
import { Episodes } from "./components/pages/Episodes";

function App(): ReactElement {
  const currentPage = useAppSelector((state) => state.router.currentPage);
  const dispatch = useAppDispatch();

  useEffect(() => {
    dispatch(fetchCharacters());
  }, []);

  return (
    <div className="App">
      <Header />
      {currentPage == Pages.LIST ? <List /> : null}
      {currentPage == Pages.FAVORITES ? <Favorites /> : null}
      {currentPage == Pages.EPISODES ? <Episodes /> : null}
    </div>
  );
}

export default App;
