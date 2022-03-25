import Ubicacion from './ubicacion.js'
import Utilidades from './utilidades.js'
import Transporte from './transporte.js'
import Envio from './envio.js'
import Paquete from './paquete.js'

export default class CalculadoraCostosEnvios {
  iniciar() {
    // Obtener el input peso del paquete
    const inputPeso = $('#peso')

    // Obtener los inputs  de dimensiones del paquete
    const inputsDimensiones = $('input', '#dimensiones-paquete')

    // Obtener los selects del form
    const selectOrigen = $('#select-origen')
    const selectDestino = $('#select-destino')
    const selectTransporte = $('#select-transporte')

    // Obtener el input de ganancia
    const inputGanancia = $('#ganancia')

    // Obtener los recipientes para las salidas
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

    // Obtener el form y escuchar al evento submit
    const form = $('#formulario')
    form.submit((event) => {
      // Evitar que se recarge la página
      event.preventDefault()

      // Crear el array de dimensiones para el paquete
      let dimensiones = []
      for (let i = 0; i < inputsDimensiones.length; i++) {
        dimensiones.push(inputsDimensiones[i].value)
      }

      // Crear un paquete
      let paquete = new Paquete(inputPeso.val(), dimensiones)

      // Crear un objeto envio con los valores del form
      const envio = new Envio(
        paquete,
        Ubicacion.ubicaciones[selectOrigen.val()],
        Ubicacion.ubicaciones[selectDestino.val()],
        Transporte.transportes[selectTransporte.val()],
        inputGanancia.val()
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
