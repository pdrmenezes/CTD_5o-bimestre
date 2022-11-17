const Character = ({ imagem, nome, especie }) => (
  <div id="card">
    <img src={imagem} alt={nome} />
    <div>
      <h2>{nome}</h2>
      <h3>{especie}</h3>
    </div>
  </div>
);

export default Character;
