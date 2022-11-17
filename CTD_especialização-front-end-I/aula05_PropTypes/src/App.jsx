import { useState } from "react";
import MessagesList from "./components/MessagesList";
import SelectedMessage from "./components/SelectedMessage";
import { messages } from "./data/messages";
import "./App.css";

export default function App() {
  const [message, setMessage] = useState(null);

  const selectMessage = (id) => setMessage(messages.find((m) => m.id === id));

  // O aplicativo tem dois componentes que recebem dados, por exemplo, de API. Para evitar erros e documentar o nosso projeto, usamos PropTupes pra declarar o tipo de dado esperado em cada componente
  return (
    <div className="App">
      <h1>Caixa de entrada</h1>
      <div id="inbox">
        <MessagesList messages={messages} selectMessage={selectMessage} />
        <SelectedMessage message={message} />
      </div>
    </div>
  );
}
