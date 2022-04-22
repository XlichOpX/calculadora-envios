import Conexion from "./conexion.js";
import ModeloForm from "./forms.js";
import ToastService from "./toasts.js";
import Validadores from "./validadores.js";

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

      if (preguntas.length > 0) {
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
        ToastService.crearToast("Correo no encontrado");
      }
    });

    // al hacer submit al form de preguntas
    this.formPreguntas.addEventListener("submit", (e) => {
      e.preventDefault();

      if (!this.validadorPreguntas.validarInputs()) return;

      const conexion = new Conexion();
      const resCorrectas = conexion.peticion("/recuperacion", "POST", {
        verificacion: "",
        correo: this.correo.value,
        respuesta1: this.inputsPreguntas["respuesta1"].value,
        respuesta2: this.inputsPreguntas["respuesta2"].value,
        respuesta3: this.inputsPreguntas["respuesta3"].value,
        "nueva-clave": this.inputsPreguntas["nueva-clave"].value,
      });

      if (resCorrectas) {
        console.log("respuestas correctas");
      } else {
        console.log("respuestas incorrectas");
      }
    });
  }
}
