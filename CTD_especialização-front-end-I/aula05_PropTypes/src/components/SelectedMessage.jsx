import React from "react";
import PropTypes from "prop-types";

function SelectedMessage({ message }) {
  if (!message) return null;

  return (
    <div id="message-shown">
      <h3 className="titulo">{message.assunto}</h3>
      <strong>
        {message.remetente} ({message.email})
      </strong>
      <p>{message.texto}</p>
    </div>
  );
}

SelectedMessage.propTypes = {
  message: PropTypes.shape({
    id: PropTypes.number.isRequired,
    remetente: PropTypes.string.isRequired,
    email: PropTypes.string.isRequired,
    assunto: PropTypes.string.isRequired,
    data: PropTypes.string.isRequired,
    texto: PropTypes.string.isRequired,
  }),
};

export default SelectedMessage;
