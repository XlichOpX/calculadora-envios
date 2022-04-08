export default class Transporte {
  static transportes = {
    moto: new Transporte("moto", 50, 50, 0.1),
    furgo: new Transporte("furgo", 45, 4000, 0.15),
  };

  constructor(nombre, velocidad, capacidad, tarifa) {
    this.nombre = nombre;
    this.velocidad = velocidad; // en km/h
    this.capacidad = capacidad; // en kg
    this.tarifa = tarifa; // en %
  }
}
