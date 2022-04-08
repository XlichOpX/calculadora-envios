import estados from './../assets/venezuela.js'
import ToastService from './toasts.js'
import Utilidades from './utilidades.js'
import Validadores from './validadores.js'

export default class Registro {
  constructor() {
    // Almacena el estado seleccionado para tener a la mano sus municipios
    this.estadoSeleccionado = null

    // Referencias al form y sus fieldsets
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

    // Agg los listeners a los inputs para su validación
    this.aggListeners()
  }

  aggListeners() {
    // Agg los listeners a cada input para validarlos cuando el usuario escriba en ellos
    this.datosBasicos['nombres'].addEventListener('input', (e) => {
      this.validarNombreApellido(this.datosBasicos['nombres'])
    })

    this.datosBasicos['apellidos'].addEventListener('input', (e) => {
      this.validarNombreApellido(this.datosBasicos['apellidos'])
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

    this.direccion['estado'].addEventListener('input', (e) => {
      this.validarEstado()
      // Debido a que automaticamente se seleccionan municipio
      // y parroquia al seleccionar estado, validar para
      // quitar sus errores
      this.validarMunicipio()
      this.validarParroquia()
    })

    this.direccion['municipio'].addEventListener('input', (e) => {
      this.validarMunicipio()
    })

    this.direccion['parroquia'].addEventListener('input', (e) => {
      this.validarParroquia()
    })

    this.direccion['calle'].addEventListener('input', (e) => {
      this.validarCalle()
    })

    this.direccion['casa-edificio'].addEventListener('input', (e) => {
      this.validarCasa()
    })

    // Validar al hacer submit
    this.form.addEventListener('submit', (e) => {
      e.preventDefault()
      const datosBasicosValidos = this.validarDatosBasicos()
      const direccionValida = this.validarDireccion()
      if (datosBasicosValidos && direccionValida) {
        this.form.reset()
        Utilidades.eliminarNodosHijos(this.direccion['municipio'])
        Utilidades.eliminarNodosHijos(this.direccion['parroquia'])
        ToastService.crearToast('¡Registro exitoso!')
      } else {
        console.log('registro fallido')
      }
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
    const nombreValido = this.validarNombreApellido(
      this.datosBasicos['nombres']
    )
    const apellidoValido = this.validarNombreApellido(
      this.datosBasicos['apellidos']
    )
    const cedulaValida = this.validarCedula()
    const telefonoValido = this.validarTelefono()
    const emailValido = this.validarEmail()
    const sexoValido = this.validarSexo()

    if (
      nombreValido &&
      apellidoValido &&
      cedulaValida &&
      telefonoValido &&
      emailValido &&
      sexoValido
    ) {
      return true
    }
    return false
  }

  // Ejecuta los validadores para la dirección
  validarDireccion() {
    const estadoValido = this.validarEstado()
    const municipioValido = this.validarMunicipio()
    const parroquiaValida = this.validarParroquia()
    const calleValida = this.validarCalle()
    const casaValida = this.validarCasa()
    if (
      estadoValido &&
      municipioValido &&
      parroquiaValida &&
      calleValida &&
      casaValida
    ) {
      return true
    }
    return false
  }

  // Valida el input dado con los parámetros dados
  // Si no es válido, muestra el msj de error dado
  validarInput(input, msjError, validadores) {
    const value = input.value
    for (let i = 0; i < validadores.length; i++) {
      const validador = validadores[i]
      if (!validador(value)) {
        this.mostrarError(input, msjError)
        return false
      }
    }
    this.borrarError(input)
    return true
  }

  validarNombreApellido(input) {
    return this.validarInput(
      input,
      'Este campo es requerido y debe tener menos de 50 caracteres',
      [Validadores.noNull, Validadores.nombre]
    )
  }

  validarCedula() {
    return this.validarInput(
      this.datosBasicos['cedula'],
      'Este campo es requerido y debe coincidir con el formato VXXXXXXXX',
      [Validadores.noNull, Validadores.cedula]
    )
  }

  validarSexo() {
    return this.validarInput(
      this.datosBasicos['sexo'],
      'Este campo es requerido.',
      [Validadores.noNull]
    )
  }

  validarEmail() {
    return this.validarInput(
      this.datosBasicos['email'],
      'Este campo es requerido y debe ser un email válido. Ejemplo: yhan.carlos2001@gmail.com',
      [Validadores.noNull, Validadores.email]
    )
  }

  validarTelefono() {
    return this.validarInput(
      this.datosBasicos['telefono'],
      'Este campo es requerido y debe coincidir con el formato 0XXXXXXXXXX. Ejemplo: 04141327382',
      [Validadores.noNull, Validadores.telefono]
    )
  }

  validarEstado() {
    return this.validarInput(
      this.direccion['estado'],
      'Este campo es requerido',
      [Validadores.noNull]
    )
  }

  validarMunicipio() {
    return this.validarInput(
      this.direccion['municipio'],
      'Este campo es requerido',
      [Validadores.noNull]
    )
  }

  validarParroquia() {
    return this.validarInput(
      this.direccion['parroquia'],
      'Este campo es requerido',
      [Validadores.noNull]
    )
  }

  validarCalle() {
    return this.validarInput(
      this.direccion['calle'],
      'Este campo es requerido',
      [Validadores.noNull]
    )
  }

  validarCasa() {
    return this.validarInput(
      this.direccion['casa-edificio'],
      'Este campo es requerido',
      [Validadores.noNull]
    )
  }

  // Coloca el msj de error en el elemento especificado
  // y le agg las clases de error activo
  mostrarError(input, msj) {
    const contenedor = input.nextElementSibling
    contenedor.textContent = msj
    contenedor.className = 'error active'
  }

  // Borra el msj de error en el elemento especificado
  // y le quita la clase active
  borrarError(input) {
    const contenedor = input.nextElementSibling
    contenedor.textContent = ''
    contenedor.className = 'error'
  }
}
