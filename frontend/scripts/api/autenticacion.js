export default class Autenticacion {
  // url base para hacer las peticiones de autenticacion
  static url = "http://calc-envios.localhost:3000/autenticacion";

  // dados un usuario y una clave, realiza una request
  // al backend para que este verifique su validez
  // si son validos, devuelve un token de acceso
  // si no, devuelve false
  static validarAcceso(usuario, clave) {
    const request = new Request(Autenticacion.url);

    const options = {
      method: "POST",
      credentials: "include",
      body: JSON.stringify({ usuario: usuario, clave: clave }),
    };

    const result = fetch(request, options)
      .then((res) => res.json())
      .then((res) => res);

    return result;
  }

  // envia una request al backend para comprobar la validez
  // del token jwt almacenado en las cookies del usuario
  static async validarToken() {
    if (!Autenticacion.obtenerJwt()) {
      return false;
    }

    const request = new Request(Autenticacion.url);

    const options = {
      method: "POST",
      credentials: "include", // para enviar las cookies
    };

    const result = await fetch(request, options)
      .then((res) => res.json())
      .then((res) => res);

    return result;
  }

  // obtiene el token jwt del usuario si existe, si no, devuelve null
  static obtenerJwt() {
    return document.cookie
      ? document.cookie
          .split("; ")
          .find((cookie) => cookie.startsWith("jwt_token="))
          .replace("jwt_token=", "")
      : null;
  }

  // parsea el jwt local a json
  static parseJwt() {
    try {
      return JSON.parse(atob(Autenticacion.obtenerJwt().split(".")[1]));
    } catch (e) {
      return null;
    }
  }
}
