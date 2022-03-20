export default class Utilidades {
  static primeraLetraMayuscula(texto) {
    return texto.charAt(0).toUpperCase() + texto.slice(1)
  }
}
