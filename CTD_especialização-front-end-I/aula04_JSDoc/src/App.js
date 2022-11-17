import { useState } from "react";
import "./styles.css";

/**
 * Returna uma string com a primeira letra de cada palavra maiúscula
 * 
 * @param {string} rawTitle Um título qualquer não formatado
 * @return {string} Um título formatado
 */
function normalizeTitle(rawTitle) {
  return rawTitle
    .split(' ')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ')
}

/**
 * Encoda uma string em base64
 * 
 * @param {string} text O texto a ser encodado
 * @return {string} O texto encodado em base64
 */
function encodeStringToBase64(text) {
  return window.btoa(text);
}


/**
 * Retorno um text base64 desencodado
 * 
 * @param {string} base64String String de base64
 * @return {string} Base64 desencodado
 */
function decodeBase64ToString(base64String) {
  return window.atob(base64String)
}

export default function App() {
  const [titulo, setTitle] = useState("");
  const [encodedText, setEncodedText] = useState("");
  const [decodedText, setDecodedText] = useState("");

  // AQUI DEVEMOS PASSAR NOSSO INPUT PELA FUNÇÃO NORMALIZADORA
  const onBlurTitleInput = (e) => setTitle(normalizeTitle(e.target.value));

  // AQUI DEVEMOS PASSAR NOSSO INPUT PELA FUNÇÃO DE ENCODE
  const onBlurTextInput = (e) => setEncodedText(encodeStringToBase64(e.target.value));

  // AQUI DEVEMOS PASSAR NOSSO INPUT PELA FUNÇÃO DE DECODE
  const onBlurEncodedTextInput = (e) => setDecodedText(decodeBase64ToString(e.target.value));

  return (
    <div className="App">
      <h1>
        Ferramentas de texto{"  "}
        <span role="img" aria-label="pencil-hand">
          ✍️
        </span>
      </h1>
      <section>
        <h2>Formato do título</h2>
        <div>
          <label htmlFor="titulo">Texto</label>
          <input
            type="text"
            placeholder="Digite o texto aqui"
            id="titulo"
            onBlur={onBlurTitleInput}
          />
          <strong>
            Resultado: <span>{titulo}</span>
          </strong>
        </div>
      </section>
      <section>
        <h2>Codificar Texto</h2>
        <div>
          <label htmlFor="textoACodificar">Texto</label>
          <input
            type="text"
            placeholder="Digite o texto aqui"
            id="textoACodificar"
            onBlur={onBlurTextInput}
          />
          <strong>
            Resultado: <span>{encodedText}</span>
          </strong>
        </div>
      </section>
      <section>
        <h2>Decodificar Texto</h2>
        <div>
          <label htmlFor="textoADecodificar">Texto</label>
          <input
            type="text"
            placeholder="Ingresa el texto aquí"
            id="textoADecodificar"
            onBlur={onBlurEncodedTextInput}
          />
          <strong>
            Resultado: <span>{decodedText}</span>
          </strong>
        </div>
      </section>
    </div>
  );
}
