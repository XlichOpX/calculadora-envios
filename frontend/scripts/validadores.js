export default class Validadores {
  // Verifica que el input no esté vacío
  static requerido(value) {
    return value !== "";
  }

  // Verifica que el nombre sea menor a 50 caracteres
  static nombre(nombre) {
    return nombre.length <= 50;
  }

  // Verifica que la cedula cumpla con el formato especificado
  static cedula(cedula) {
    const cedulaRegExp = /^[VEJvej]\d+/;
    return cedulaRegExp.test(cedula);
  }

  // Verifica que el email cumpla con el formato especificado
  static email(email) {
    const emailRegExp =
      /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
    return emailRegExp.test(email);
  }

  // Verifica que el telefono cumpla con el formato especificado
  static telefono(telefono) {
    const telefonoRegExp = /^[0]\d{10}/;
    return telefonoRegExp.test(telefono);
  }
  }
}
