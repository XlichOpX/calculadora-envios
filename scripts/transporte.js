export default class Transporte {
  static transportes = {
    moto: new Transporte('moto', 60, 50, 0.2),
    furgo: new Transporte('furgo', 45, 4000, 0.3)
  }

  constructor(nombre, velocidad, capacidad, tarifa) {
    this.nombre = nombre
    this.velocidad = velocidad // en km/h
    this.capacidad = capacidad // en kg
    this.tarifa = tarifa // en %
  }
}
