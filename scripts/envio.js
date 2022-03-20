class Envio {
  constructor(origen, destino, transporte, tarifa) {
    this.origen = origen
    this.destino = destino
    this.transporte = transporte
    this.distancia = Ubicacion.calcularDistancia(this.origen, this.destino)
    this.tarifa = tarifa / 100 // Pasar el % a su forma decimal
    this.precio = this.calcularPrecio()
    this.tiempoEstimado = this.calcularTiempoEstimado()
  }

  calcularPrecio() {
    // El precio general será de 0.5$ por km de recorrido
    let precio = 0.5
    // El precio será entonces 0.5$ * la distancia en km
    precio *= this.distancia
    // + el % de la tarifa
    precio += precio * this.tarifa
    return precio
  }

  calcularTiempoEstimado() {
    const tiempoEstimado = this.distancia / this.transporte.velocidad
    return tiempoEstimado
  }
}
