import Validadores from "./validadores.js";
import Autenticacion from "./autenticacion.js";

export default class Login {
  constructor() {
    this.login = document.getElementById("login");
    this.correo = document.getElementById("correo");
    this.clave = document.getElementById("clave");

    this.login.addEventListener("submit", (e) => {
      e.preventDefault();
      this.validar();
    });
  }

  async validar() {
    if (!this.correo.value || !this.clave.value) {
      alert("Todos los campos son requeridos!");
      return;
    }

    if (!Validadores.email(this.correo.value)) {
      alert("Introduce un correo válido!");
      return;
    }
    const valido = await Autenticacion.validarAcceso(
      this.correo.value,
      this.clave.value
    );

    if (valido) {
      window.location.href = "/calculadora";
      return;
    }

    alert("Datos de acceso incorrectos!");
  }
}
