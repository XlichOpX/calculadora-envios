import Conexion from "/scripts/api/conexion.js";
import ModeloForm from "/scripts/utilidades/forms.js";
import ToastService from "/scripts/utilidades/toasts.js";
import Validadores from "/scripts/utilidades/validadores.js";

export default class RecuperarClave {
  constructor() {
    // referencia al form del correo a buscar
    this.formCorreo = document.getElementById("form-correo");
    this.correo = document.getElementById("correo");

    // crear validador para el form del correo
    this.validadorCorreo = new ModeloForm([
      [this.correo, [Validadores.requerido, Validadores.email]],
    ]);

    // referencia al form de preguntas
    this.formPreguntas = document.getElementById("preguntas");
    this.inputsPreguntas = this.formPreguntas.elements;

    // crear validador para el form de preguntas
    this.validadorPreguntas = new ModeloForm([
      [this.inputsPreguntas["respuesta1"], [Validadores.requerido]],
      [this.inputsPreguntas["respuesta2"], [Validadores.requerido]],
      [this.inputsPreguntas["respuesta3"], [Validadores.requerido]],
      [
        this.inputsPreguntas["nueva-clave"],
        [Validadores.requerido, Validadores.clave],
      ],
    ]);

    // al hacer submit al form del correo
    this.formCorreo.addEventListener("submit", async (e) => {
      e.preventDefault();

      if (!this.validadorCorreo.validarInputs()) return;

      // pedir las preguntas de seguridad para el correo dado
      const conexion = new Conexion();
      const preguntas = await conexion.peticion("/recuperacion", "POST", {
        correo: this.correo.value,
      });

      if (!preguntas.error) {
        // esconder el form de correo
        this.formCorreo.style = "display: none";

        // agg el texto de cada pregunta
        preguntas.forEach((pregunta, index) => {
          document.getElementById(`pregunta${index + 1}`).textContent =
            pregunta.pregunta;
        });

        // mostrar el form de preguntas
        this.formPreguntas.style = "";
      } else {
        ToastService.crearToast(preguntas.error, { class: "fail" });
      }
    });

    // al hacer submit al form de preguntas
    this.formPreguntas.addEventListener("submit", async (e) => {
      e.preventDefault();

      if (!this.validadorPreguntas.validarInputs()) return;

      const conexion = new Conexion();
      const resCorrectas = await conexion.peticion("/recuperacion", "POST", {
        verificacion: "",
        correo: this.correo.value,
        respuesta1: this.inputsPreguntas["respuesta1"].value,
        respuesta2: this.inputsPreguntas["respuesta2"].value,
        respuesta3: this.inputsPreguntas["respuesta3"].value,
        "nueva-clave": this.inputsPreguntas["nueva-clave"].value,
      });

      if (!resCorrectas.error) {
        ToastService.crearToast("Contraseña cambiada exitosamente", {
          class: "success",
        });
        window.location.href = "/login";
        return;
      } else {
        e.target.reset();
        ToastService.crearToast(resCorrectas.error, {
          class: "fail",
        });
      }
    });
  }
}
