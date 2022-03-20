class Envio {
  constructor(origen, destino, tarifa = 0.2) {
    this.tarifa = tarifa / 100
    this.origen = origen
    this.destino = destino
    this.precio = this.calcularPrecio()
  }

  calcularPrecio() {
    // El precio general será de 0.5$ por km de recorrido
    let precio = 0.5
    // El precio será entonces 0.5$ * la distancia en km
    precio *= Ubicacion.calcularDistancia(this.origen, this.destino)
    // + el % de la tarifa
    precio += precio * this.tarifa
    return precio
  }
}
