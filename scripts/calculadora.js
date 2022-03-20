class CalculadoraCostosEnvios {
  encender() {
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
      let nombreEnMayuscula =
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
  }
}
