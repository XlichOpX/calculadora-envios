class Ubicacion {
  static ubicaciones = {
    caracas: new Ubicacion('caracas', 0, 0),
    maracay: new Ubicacion('maracay', 10, 10),
    valencia: new Ubicacion('valencia', 30, 30)
  }

  constructor(nombre, x, y) {
    this.nombre = nombre
    this.x = x
    this.y = y
  }

  static calcularDistancia(origen, destino) {
    // Retornar la distancia entre dos puntos usando la fórmula
    // de la distancia entre dos puntos
    return Math.sqrt((destino.x - origen.x) ** 2 + (destino.y - origen.y) ** 2)
  }
}
