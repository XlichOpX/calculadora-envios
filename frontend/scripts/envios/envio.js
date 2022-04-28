import Ubicacion from "./ubicacion.js";

export default class Envio {
  constructor(paquete, origen, destino, transporte) {
    this.paquete = paquete;
    this.origen = origen;
    this.destino = destino;
    this.transporte = transporte;
    this.distancia = Ubicacion.calcularDistancia(this.origen, this.destino);
    this.precio = this.calcularPrecio();
    this.tiempoEstimado = this.calcularTiempoEstimado();
  }

  calcularPrecio() {
    if (this.distancia === 0) return 2;

    // El precio base será de 0.02$ por km de recorrido
    const precioBase = this.distancia * 0.02;

    // + el % de la tarifa
    let precio = precioBase + precioBase;

    // + el % del tipo de transporte
    precio += precioBase * this.transporte.tarifa;

    // + un % del peso del paquete
    // (se toma una décima parte de gananciaConductor para
    // que el costo no sea exageradamente grande)
    precio += this.paquete.peso * 0.01;

    // + un % del volumen del paquete
    // (se toma una décima parte de gananciaConductor para
    // que el costo no sea exageradamente grande)
    precio += this.paquete.volumen * 0.01;

    return precio;
  }

  calcularTiempoEstimado() {
    const tiempoEstimado = this.distancia / this.transporte.velocidad_promedio;
    return tiempoEstimado; // en horas
  }
}
