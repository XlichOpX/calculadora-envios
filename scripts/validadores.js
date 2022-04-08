export default class Validadores {
  // Verifica que el input no esté vacío
  static noNull(value) {
    if (value !== '') return true
    return false
  }

  // Verifica que el nombre sea menor a 50 caracteres
  static nombre(nombre) {
    if (nombre.length < 50) return true
    return false
  }

  // Verifica que la cedula cumpla con el formato especificado
  static cedula(cedula) {
    const cedulaRegExp = /^[VEJvej]\d+/
    if (cedulaRegExp.test(cedula)) return true
    return false
  }

  // Verifica que el email cumpla con el formato especificado
  static email(email) {
    const emailRegExp =
      /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/
    if (emailRegExp.test(email)) return true
    return false
  }

  // Verifica que el telefono cumpla con el formato especificado
  static telefono(telefono) {
    const telefonoRegExp = /^[0]\d{10}/
    if (telefonoRegExp.test(telefono)) return true
    return false
  }
}
