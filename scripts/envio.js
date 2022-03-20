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
    // El precio base será de 0.5$ por km de recorrido
    const precioBase = this.distancia * 0.5

    // + el % de la tarifa
    let precio = precioBase + precioBase * this.tarifa

    // + el % del tipo de transporte
    precio += precioBase * this.transporte.tarifa
    return precio
  }

  calcularTiempoEstimado() {
    const tiempoEstimado = this.distancia / this.transporte.velocidad
    return tiempoEstimado // en horas
  }
}
