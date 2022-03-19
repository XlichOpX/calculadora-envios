class Envio {
  constructor(origen, destino, tarifa = 0.2) {
    this.tarifa = tarifa
    this.origen = origen
    this.destino = destino
    this.precio = this.calcularPrecio()
  }

  calcularPrecio() {
    // Digamos que el precio general será de 0.5$ por km de recorrido
    let precio = 0.5
    // El precio será entonces 0.5$ * la distancia en km
    precio *= Ubicacion.calcularDistancia(this.origen, this.destino)
    // + el % de la tarifa
    precio += precio * this.tarifa
    return precio
  }
}

class Ubicacion {
  constructor(nombre, x, y) {
    this.nombre = nombre
    this.x = x
    this.y = y
  }

  static calcularDistancia(origen, destino) {
    // Retorna la distancia entre dos puntos usando la fórmula
    // de la distancia entre dos puntos
    return Math.sqrt((destino.x - origen.x) ** 2 + (destino.y - origen.y) ** 2)
  }
}
