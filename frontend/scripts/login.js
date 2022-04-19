import Validadores from "./validadores.js";

export default class Login {
  iniciar() {
    this.login = document.getElementById("login");
    this.correo = document.getElementById("correo");
    this.clave = document.getElementById("clave");

    this.login.addEventListener("submit", (e) => {
      e.preventDefault();
      this.validar();
    });
  }

  validar() {
    if (!this.correo.value || !this.clave.value) {
      alert("Todos los campos son requeridos!");
      return;
    }

    if (!Validadores.email(this.correo.value)) {
      alert("Introduce un correo válido!");
      return;
    }

    this.validarAcceso();
  }

  validarAcceso() {
    const request = new XMLHttpRequest();
    request.open("POST", "http://calc-envios.localhost:3000/autenticacion");

    // para permitir las cookies
    request.withCredentials = true;

    // envia los datos de acceso en un blob
    const data = new Blob([
      JSON.stringify({ usuario: this.correo.value, clave: this.clave.value }),
    ]);
    request.send(data);

    // al terminar la request
    request.addEventListener("load", () => {
      if (request.response === "true") {
        alert("Datos validos");
        return;
      }
      alert("Datos invalidos");
      return;
    });
  }
}
