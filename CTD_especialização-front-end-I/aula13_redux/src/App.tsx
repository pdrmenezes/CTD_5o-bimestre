import { useState } from "react";
import "./App.css";
import Incrementer from "./Incrementer";
import Count from "./Count";

function App() {
  const [count, setCount] = useState(0);

  return (
    <div className="App">
      <h1>From useState to Redux</h1>
      <div>
        <Count />
        <Incrementer setCount={setCount} />
      </div>
    </div>
  );
}

export default App;
