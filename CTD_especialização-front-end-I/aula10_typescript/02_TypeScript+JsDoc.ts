// @deprecated define algum trecho de código ou função como obsoleta

//* @deprecated: porque a funcionalidade deixou de existir */
const apiV1 = {};

const apiV2 = {};

// @see permite referenciar outro conteúdo relacionado 

//* @see exemplo  
* ambos serão vinculados à função bar
* @see {@link bar}
* @see bar
*/


// @link cria um caminho ou url a ser acessada. o texto do link também pode ser fornecido

//* @link exemplo
* {@link caminho ou URL}
* [Digital House]{@link caminho ou URL}
* @link {https://github.com/pdrmenezes}
* {@link https://github.com/pdrmenezes}
*/

// @enum documenta uma coleção de propriedades estáticas cujos valores são do mesmo tipo. frequentemente utilizada com @readonly, pois geralmente representa uma coleção de constantes
//* @enum exemplo
* @readonly
* @enum {number}
*/
var triState = {
  TRUE = 1,
  FALSE = -1,
  //* @type {boolean} */
  MAYBE = true
}

//* @author identifica o autor de um item - se o nome for seguido por um endereço de email entre colchetes, o modelo padrão converterá o endereço de email para um mailto:email
//*
* Bem vindo ao github.ts
* @author <pdrmenezes1@gmail.com>
*/