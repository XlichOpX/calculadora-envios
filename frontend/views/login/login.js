import Validadores from "/scripts/validadores.js";
import Autenticacion from "/scripts/autenticacion.js";
import ModeloForm from "/scripts/forms.js";
import ToastService from "/scripts/toasts.js";

export default class Login {
  constructor() {
    this.login = document.getElementById("login");
    this.correo = document.getElementById("correo");
    this.clave = document.getElementById("clave");

    this.modeloForm = new ModeloForm([
      [this.correo, [Validadores.requerido, Validadores.email]],
      [this.clave, [Validadores.requerido]],
    ]);

    this.login.addEventListener("submit", (e) => {
      e.preventDefault();
      if (this.modeloForm.validarInputs()) {
        this.validarAcceso();
      }
    });
  }

  async validarAcceso() {
    const valido = await Autenticacion.validarAcceso(
      this.correo.value,
      this.clave.value
    );

    if (valido) {
      window.location.href = "/calculadora";
      return;
    }

    ToastService.crearToast("Datos de acceso incorrectos", { class: "fail" });
  }
}
