import estados from './../assets/venezuela.js'
import Utilidades from './utilidades.js'

export default class Registro {
  constructor() {
    this.estadoSeleccionado = null
    this.inputs = document.getElementById('form-registro').elements
  }

  iniciar() {
    // Para cada estado del json de direcciones agg una opcion
    // en el select correspondiente
    estados.forEach((estado) => {
      this.aggOption(this.inputs['estado'], estado.estado)
    })

    // Cuando el usuario seleccione un estado, actualizar
    // los selects de municipios y parroquias
    this.inputs['estado'].addEventListener('change', (e) => {
      this.actMunicipios()
      this.actParroquias()
    })

    // Cuando el usuario seleccione un municipio, actualizar las parroquias
    this.inputs['municipio'].addEventListener('change', (e) => {
      this.actParroquias()
    })
  }

  // Crea un elemento option y lo agg al select dado
  aggOption(select, value) {
    const opcion = document.createElement('option')
    opcion.textContent = value
    opcion.value = value
    select.appendChild(opcion)
  }

  // Actualizar las parroquias del select de parroquias
  actParroquias() {
    // Limpiar lo que pueda haber actualmente en el select
    Utilidades.eliminarNodosHijos(this.inputs['parroquia'])

    // Recorrer los municipios del estado seleccionado
    for (let i = 0; i < this.estadoSeleccionado.municipios.length; i++) {
      const municipio = this.estadoSeleccionado.municipios[i]

      // Si el elemento actual del bucle coincide con
      // el municipio seleccionado en el select
      if (municipio.municipio == this.inputs['municipio'].value) {
        // Agg los options de cada parroquia
        municipio.parroquias.forEach((parroquia) => {
          this.aggOption(this.inputs['parroquia'], parroquia)
        })
        break
      }
    }
  }

  // Actualizar los municipios del select de municipios
  actMunicipios() {
    // Limpiar lo que pueda haber actualmente en el select
    Utilidades.eliminarNodosHijos(this.inputs['municipio'])

    // Recorrer los municipios del estado seleccionado
    for (let i = 0; i < estados.length; i++) {
      const estado = estados[i]

      // Si el elemento actual del bucle coincide con
      // el estado seleccionado en el select
      if (estado.estado == this.inputs['estado'].value) {
        // Guardar el estado seleccionado para acceder facilmente
        // a sus municipios y a las parroquias de cada municipio
        this.estadoSeleccionado = estado

        // Agg los options de cada municipio
        estado.municipios.forEach((municipio) => {
          this.aggOption(this.inputs['municipio'], municipio.municipio)
        })
        break
      }
    }
  }
}
