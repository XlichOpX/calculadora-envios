import Ubicacion from './ubicacion.js'

export default class Envio {
  constructor(paquete, origen, destino, transporte, gananciaCondcutor) {
    this.paquete = paquete
    this.origen = origen
    this.destino = destino
    this.transporte = transporte
    this.distancia = Ubicacion.calcularDistancia(this.origen, this.destino)
    this.gananciaConductor = gananciaCondcutor / 100 // Pasar el % a su forma decimal
    this.precio = this.calcularPrecio()
    this.tiempoEstimado = this.calcularTiempoEstimado()
  }

  calcularPrecio() {
    if (this.distancia === 0) return 2

    // El precio base será de 0.02$ por km de recorrido
    const precioBase = this.distancia * 0.02

    // + el % de la tarifa
    let precio = precioBase + precioBase * this.gananciaConductor

    // + el % del tipo de transporte
    precio += precioBase * this.transporte.tarifa

    // + un % del peso del paquete
    // (se toma una décima parte de gananciaConductor para
    // que el costo no sea exageradamente grande)
    precio += this.paquete.peso * (this.gananciaConductor / 20)

    // + un % del volumen del paquete
    // (se toma una décima parte de gananciaConductor para
    // que el costo no sea exageradamente grande)
    precio += this.paquete.volumen * (this.gananciaConductor / 20)

    return precio
  }

  calcularTiempoEstimado() {
    const tiempoEstimado = this.distancia / this.transporte.velocidad
    return tiempoEstimado // en horas
  }
}
