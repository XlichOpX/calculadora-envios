import Ubicacion from './ubicacion.js'
import Utilidades from './utilidades.js'
import Transporte from './transporte.js'
import Envio from './envio.js'

export default class CalculadoraCostosEnvios {
  iniciar() {
    // Obtener las referencias a los selects del form
    const selectOrigen = $('#select-origen')
    const selectDestino = $('#select-destino')
    const selectTransporte = $('#select-transporte')

    // Obtener la referencia al input de tarifa
    const inputTarifa = $('#tarifa')

    // Obtener las referencias a los recipientes de las salidas
    const recipientePrecio = $('#precio-calculado')
    const recipienteDistancia = $('#distancia-recorrida')
    const recipienteTiempoEstimado = $('#tiempo-estimado')

    // Agregar cada ubicación de la clase Ubicacion como options a cada select
    Object.values(Ubicacion.ubicaciones).forEach((ubicacion) => {
      // Convertir la primera letra de cada nombre en mayúsculas para mejor presentación
      const nombreEnMayuscula = Utilidades.primeraLetraMayuscula(
        ubicacion.nombre
      )
      selectOrigen.append(new Option(nombreEnMayuscula, ubicacion.nombre))
      selectDestino.append(new Option(nombreEnMayuscula, ubicacion.nombre))
    })

    Object.values(Transporte.transportes).forEach((transporte) => {
      const nombreEnMayuscula = Utilidades.primeraLetraMayuscula(
        transporte.nombre
      )
      selectTransporte.append(new Option(nombreEnMayuscula, transporte.nombre))
    })

    // Obtener la referencia al form y escuchar al evento submit
    const form = $('#formulario')
    form.submit((event) => {
      // Evitar que se recarge la página
      event.preventDefault()
      console.log('hola')

      // Crear un objeto envio con los valores del form
      const envio = new Envio(
        Ubicacion.ubicaciones[selectOrigen.val()],
        Ubicacion.ubicaciones[selectDestino.val()],
        Transporte.transportes[selectTransporte.val()],
        inputTarifa.val()
      )

      // Mostrar el precio calculado
      recipientePrecio.text(`Costo del envío: $${envio.precio.toFixed(2)}`)
      recipienteDistancia.text(
        `Distancia a recorrer: ${envio.distancia.toFixed(2)} km`
      )
      recipienteTiempoEstimado.text(
        `Tiempo de recorrido estimado: ${envio.tiempoEstimado.toFixed(2)} horas`
      )
    })
  }
}
