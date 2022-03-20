class Transporte {
  static transportes = {
    moto: new Transporte('moto', 50, 50),
    furgo: new Transporte('furgo', 50, 4000)
  }

  constructor(nombre, velocidad, capacidad) {
    this.nombre = nombre
    this.velocidad = velocidad // en km/h
    this.capacidad = capacidad // en kg
  }
}
