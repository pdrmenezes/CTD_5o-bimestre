import { React } from "react";
import PropTypes from "prop-types";

const Input = ({ name, label, onChange, type = "text" }) => {
  const onBlur = (event) => {
    onChange(event.target.value);
  };

  return (
    <div className="input-receptor">
      <label htmlFor={name}>{label}</label>
      <input type={type} id={name} onBlur={onBlur} />
    </div>
  );
};

Input.propTypes = {
  name: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired,
  type: PropTypes.string,
};

export default Input;
