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

class Ubicacion {
  static ubicaciones = {
    caracas: new Ubicacion('caracas', 0, 0),
    maracay: new Ubicacion('maracay', 10, 10),
    valencia: new Ubicacion('valencia', 30, 30)
  }

  constructor(nombre, x, y) {
    this.nombre = nombre
    this.x = x
    this.y = y
  }

  static calcularDistancia(origen, destino) {
    // Retornar la distancia entre dos puntos usando la fórmula
    // de la distancia entre dos puntos
    return Math.sqrt((destino.x - origen.x) ** 2 + (destino.y - origen.y) ** 2)
  }
}

// Obtener las referencias a los selects del form
let selectOrigen = document.getElementById('select-origen')
let selectDestino = document.getElementById('select-destino')

// Obtener la referencia al input de tarifa
let inputTarifa = document.getElementById('tarifa')

// Obtener la referencia al párrafo del precio
let parrafoPrecio = document.getElementById('precio-calculado')

// Agregar cada ubicación de la clase Ubicacion como options a cada select
Object.values(Ubicacion.ubicaciones).forEach((ubicacion) => {
  // Convertir la primera letra de cada nombre en mayúsculas para mejor presentación
  nombreEnMayuscula =
    ubicacion.nombre.charAt(0).toUpperCase() + ubicacion.nombre.slice(1)
  selectOrigen.appendChild(new Option(nombreEnMayuscula, ubicacion.nombre))
  selectDestino.appendChild(new Option(nombreEnMayuscula, ubicacion.nombre))
})

// Obtener la referencia al form y escuchar al evento submit
let form = document.getElementById('formulario')
form.addEventListener('submit', (event) => {
  // Evitar que se recarge la página
  event.preventDefault()

  // Crear un objeto envio con los valores del form
  let envio = new Envio(
    Ubicacion.ubicaciones[selectOrigen.value],
    Ubicacion.ubicaciones[selectDestino.value],
    inputTarifa.value
  )

  // Mostrar el precio calculado
  parrafoPrecio.innerText = `$${envio.precio.toFixed(2)}`
})
