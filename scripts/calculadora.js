class CalculadoraCostosEnvios {
  encender() {
    // Obtener las referencias a los selects del form
    const selectOrigen = document.getElementById('select-origen')
    const selectDestino = document.getElementById('select-destino')
    const selectTransporte = document.getElementById('select-transporte')

    // Obtener la referencia al input de tarifa
    const inputTarifa = document.getElementById('tarifa')

    // Obtener las referencias a los recipientes de las salidas
    const recipientePrecio = document.getElementById('precio-calculado')
    const recipienteDistancia = document.getElementById('distancia-recorrida')
    const recipienteTiempoEstimado = document.getElementById('tiempo-estimado')

    // Agregar cada ubicación de la clase Ubicacion como options a cada select
    Object.values(Ubicacion.ubicaciones).forEach((ubicacion) => {
      // Convertir la primera letra de cada nombre en mayúsculas para mejor presentación
      const nombreEnMayuscula = Utilidades.primeraLetraMayuscula(
        ubicacion.nombre
      )
      selectOrigen.appendChild(new Option(nombreEnMayuscula, ubicacion.nombre))
      selectDestino.appendChild(new Option(nombreEnMayuscula, ubicacion.nombre))
    })

    Object.values(Transporte.transportes).forEach((transporte) => {
      const nombreEnMayuscula = Utilidades.primeraLetraMayuscula(
        transporte.nombre
      )
      selectTransporte.appendChild(
        new Option(nombreEnMayuscula, transporte.nombre)
      )
    })

    // Obtener la referencia al form y escuchar al evento submit
    const form = document.getElementById('formulario')
    form.addEventListener('submit', (event) => {
      // Evitar que se recarge la página
      event.preventDefault()

      // Crear un objeto envio con los valores del form
      const envio = new Envio(
        Ubicacion.ubicaciones[selectOrigen.value],
        Ubicacion.ubicaciones[selectDestino.value],
        Transporte.transportes[selectTransporte.value],
        inputTarifa.value
      )

      // Mostrar el precio calculado
      recipientePrecio.innerText = `Costo del envío: $${envio.precio.toFixed(
        2
      )}`
      recipienteDistancia.innerText = `Distancia a recorrer: ${envio.distancia.toFixed(
        2
      )} km`
      recipienteTiempoEstimado.innerText = `Tiempo de recorrido estimado: ${envio.tiempoEstimado.toFixed(
        2
      )} horas`
    })
  }
}
