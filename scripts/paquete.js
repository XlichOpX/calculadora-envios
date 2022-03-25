export default class Paquete {
  constructor(peso, dimensiones) {
    this.peso = peso
    // Debe ser un array de 3 posiciones
    this.dimensiones = dimensiones
    this.volumen = this.calcularVolumen()
  }

  calcularVolumen() {
    // Se inicia a 1 para que se pueda multiplicar
    // cada posición del array
    let volumen = 1
    this.dimensiones.forEach((dimension) => {
      volumen *= dimension
    })
    return volumen
  }
}
