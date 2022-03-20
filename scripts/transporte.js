class Transporte {
  transportes = {
    moto: new Transporte(50, 50),
    furgo: new Transporte(50, 4000)
  }

  constructor(velocidad, capacidad) {
    this.velocidad = velocidad // en km/h
    this.capacidad = capacidad // en kg
  }
}
