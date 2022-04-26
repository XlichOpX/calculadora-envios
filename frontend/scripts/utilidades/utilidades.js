export default class Utilidades {
  static primeraLetraMayuscula(texto) {
    return texto.charAt(0).toUpperCase() + texto.slice(1);
  }

  static eliminarNodosHijos(elemento) {
    while (elemento.firstChild) {
      elemento.removeChild(elemento.firstChild);
    }
  }
}
