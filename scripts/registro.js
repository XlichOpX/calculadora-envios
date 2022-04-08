import estados from './../assets/venezuela.js'
import Utilidades from './utilidades.js'
import Validadores from './validadores.js'

export default class Registro {
  constructor() {
    // Almacena el estado seleccionado para tener a la mano sus municipios
    this.estadoSeleccionado = null

    // Referencias al form y sus inputs
    this.form = document.getElementById('form-registro')
    this.datosBasicos = document.getElementById('datos-basicos').elements
    this.direccion = document.getElementById('direccion').elements
  }

  iniciar() {
    // Para cada estado del json de direcciones agg una opcion
    // en el select correspondiente
    estados.forEach((estado) => {
      this.aggOption(this.direccion['estado'], estado.estado)
    })

    // Cuando el usuario seleccione un estado, actualizar
    // los selects de municipios y parroquias
    this.direccion['estado'].addEventListener('input', (e) => {
      this.actMunicipios()
      this.actParroquias()
    })

    // Cuando el usuario seleccione un municipio, actualizar las parroquias
    this.direccion['municipio'].addEventListener('input', (e) => {
      this.actParroquias()
    })

    // Agg los listeners a los inputs
    this.aggListeners()
  }

  aggListeners() {
    // Agg los listeners a cada input para validarlos cuando el usuario escriba en ellos
    this.datosBasicos['nombres'].addEventListener('input', (e) => {
      this.validarNombre(this.datosBasicos['nombres'])
    })

    this.datosBasicos['apellidos'].addEventListener('input', (e) => {
      this.validarNombre(this.datosBasicos['apellidos'])
    })

    this.datosBasicos['cedula'].addEventListener('input', (e) => {
      this.validarCedula()
    })

    this.datosBasicos['telefono'].addEventListener('input', (e) => {
      this.validarTelefono()
    })

    this.datosBasicos['email'].addEventListener('input', (e) => {
      this.validarEmail()
    })

    this.datosBasicos['sexo'].addEventListener('input', (e) => {
      this.validarSexo()
    })

    // Validar al hacer submit
    this.form.addEventListener('submit', (e) => {
      e.preventDefault()
      this.validarDatosBasicos()
    })
  }

  // Actualizar las parroquias del select de parroquias
  actParroquias() {
    // Limpiar lo que pueda haber actualmente en el select
    Utilidades.eliminarNodosHijos(this.direccion['parroquia'])

    // Recorrer los municipios del estado seleccionado
    for (let i = 0; i < this.estadoSeleccionado.municipios.length; i++) {
      const municipio = this.estadoSeleccionado.municipios[i]

      // Si el elemento actual del bucle coincide con
      // el municipio seleccionado en el select
      if (municipio.municipio == this.direccion['municipio'].value) {
        // Agg los options de cada parroquia
        municipio.parroquias.forEach((parroquia) => {
          this.aggOption(this.direccion['parroquia'], parroquia)
        })
        break
      }
    }
  }

  // Actualizar los municipios del select de municipios
  actMunicipios() {
    // Limpiar lo que pueda haber actualmente en el select
    Utilidades.eliminarNodosHijos(this.direccion['municipio'])

    // Recorrer los municipios del estado seleccionado
    for (let i = 0; i < estados.length; i++) {
      const estado = estados[i]

      // Si el elemento actual del bucle coincide con
      // el estado seleccionado en el select
      if (estado.estado == this.direccion['estado'].value) {
        // Guardar el estado seleccionado para acceder facilmente
        // a sus municipios y a las parroquias de cada municipio
        this.estadoSeleccionado = estado

        // Agg los options de cada municipio
        estado.municipios.forEach((municipio) => {
          this.aggOption(this.direccion['municipio'], municipio.municipio)
        })
        break
      }
    }
  }

  // Crea un elemento option y lo agg al select dado
  aggOption(select, value) {
    const opcion = document.createElement('option')
    opcion.textContent = value
    opcion.value = value
    select.appendChild(opcion)
  }

  // Ejecuta los validadores para los datos básicos
  validarDatosBasicos() {
    this.validarNombre(this.datosBasicos['nombres'])
    this.validarNombre(this.datosBasicos['apellidos'])
    this.validarCedula()
    this.validarTelefono()
    this.validarEmail()
    this.validarSexo()
  }

  // Valida que sea menor a 50 caracteres y da feedback al usuario
  // Recibe un parametro para validar tanto los nombres
  // como los apellidos
  validarNombre(input) {
    const nombre = input.value
    const contenedorError = input.nextElementSibling
    if (nombre !== '' && Validadores.nombre(nombre)) {
      this.borrarError(contenedorError)
      return true
    } else {
      this.mostrarError(
        contenedorError,
        'Este campo es requerido y debe tener menos de 50 caracteres'
      )
      return false
    }
  }

  // Valida que la cedula cumpla con el formato necesario
  // y da feedback al usuario
  validarCedula() {
    const cedula = this.datosBasicos['cedula'].value
    const contenedorError = this.datosBasicos['cedula'].nextElementSibling
    if (cedula !== '' && Validadores.cedula(cedula)) {
      this.borrarError(contenedorError)
      return true
    } else {
      this.mostrarError(
        contenedorError,
        'Este campo es requerido y debe coincidir con el formato VXXXXXXXX'
      )
      return false
    }
  }

  // Valida que el telefono cumpla con el formato necesario
  // y da feedback al usuario
  validarTelefono() {
    const telefono = this.datosBasicos['telefono'].value
    const contenedorError = this.datosBasicos['telefono'].nextElementSibling
    if (telefono !== '' && Validadores.telefono(telefono)) {
      this.borrarError(contenedorError)
      return true
    } else {
      this.mostrarError(
        contenedorError,
        'Este campo es requerido y debe coincidir con el formato 0XXXXXXXXXX. Ejemplo: 04141327382'
      )
      return false
    }
  }

  // Valida que el email cumpla con el formato necesario
  // y da feedback al usuario
  validarEmail() {
    const email = this.datosBasicos['email'].value
    const contenedorError = this.datosBasicos['email'].nextElementSibling
    if (email !== '' && Validadores.email(email)) {
      this.borrarError(contenedorError)
      return true
    } else {
      this.mostrarError(
        contenedorError,
        'Este campo es requerido y debe ser un email válido. Ejemplo: yhan.carlos2001@gmail.com'
      )
      return false
    }
  }

  // Valida que se halla seleccionado un sexo
  validarSexo() {
    const sexo = this.datosBasicos['sexo'].value
    const contenedorError = this.datosBasicos['sexo'].nextElementSibling
    if (sexo !== '') {
      this.borrarError(contenedorError)
      return true
    } else {
      this.mostrarError(contenedorError, 'Este campo es requerido')
      return false
    }
  }

  // Coloca el msj de error en el elemento especificado
  // y le agg las clases de error activo
  mostrarError(contenedor, msj) {
    contenedor.textContent = msj
    contenedor.className = 'error active'
  }

  // Borra el msj de error en el elemento especificado
  // y le quita la clase active
  borrarError(contenedor) {
    contenedor.textContent = ''
    contenedor.className = 'error'
  }
}
