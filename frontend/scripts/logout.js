export default class Logout {
  constructor() {
    // borrar la cookie de acceso
    document.cookie =
      "jwt_token= ; expires = Thu, 01 Jan 1970 00:00:00 GMT; path=/; domain=.calc-envios.localhost";

    // redirige al login
    window.location.href = "/login";
  }
}
