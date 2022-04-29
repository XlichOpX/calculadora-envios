export default class Utilidades {
  static primeraLetraMayuscula(texto) {
    return texto.charAt(0).toUpperCase() + texto.slice(1);
  }

  static eliminarNodosHijos(elemento) {
    while (elemento.firstChild) {
      elemento.removeChild(elemento.firstChild);
    }
  }

  static buscarObjEnArray(id, objArray) {
    for (let i = 0; i < objArray.length; i++) {
      const obj = objArray[i];
      if (obj.id == id) {
        return obj;
      }
    }
  }
}
