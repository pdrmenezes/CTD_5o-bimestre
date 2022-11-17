import React from "react";
import PropTypes from "prop-types";

export default function MessagesList({ messages = [], selectMessage }) {
  return (
    <div id="messages-list">
      {messages.map((message) => (
        <div onClick={() => selectMessage(message.id)} key={message.id}>
          <strong>De: {message.remetente}</strong>
          <p>Assunto: {message.assunto}</p>
          <small> {message.data}</small>
        </div>
      ))}
    </div>
  );
}

MessagesList.propTypes = {
  selectMessage: PropTypes.func.isRequired,
  messages: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.number.isRequired,
      remetente: PropTypes.string.isRequired,
      assunto: PropTypes.string.isRequired,
      data: PropTypes.string.isRequired,
    })
  ),
};
