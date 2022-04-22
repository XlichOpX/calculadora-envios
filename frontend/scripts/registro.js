import estados from "./../assets/venezuela.js";
import ToastService from "./toasts.js";
import Utilidades from "./utilidades.js";
import Validadores from "./validadores.js";
import Conexion from "./conexion.js";

export default class Registro {
  constructor() {
    // Referencias al form y sus fieldsets
    this.form = document.getElementById("form-registro");
    this.inputsForm = document.getElementById("form-registro").elements;

    this.modeloForm = [
      [this.inputsForm["nombre"], [Validadores.requerido, Validadores.nombre]],
      [
        this.inputsForm["apellido"],
        [Validadores.requerido, Validadores.nombre],
      ],
      [this.inputsForm["cedula"], [Validadores.requerido, Validadores.cedula]],
      [this.inputsForm["fecha_nacimiento"], [Validadores.requerido]],
      [
        this.inputsForm["telefono"],
        [Validadores.requerido, Validadores.telefono],
      ],
      [this.inputsForm["email"], [Validadores.requerido, Validadores.email]],
      [this.inputsForm["clave"], [Validadores.requerido, Validadores.clave]],
      [this.inputsForm["pregunta1"], [Validadores.requerido]],
      [this.inputsForm["respuesta1"], [Validadores.requerido]],
      [this.inputsForm["pregunta2"], [Validadores.requerido]],
      [this.inputsForm["respuesta2"], [Validadores.requerido]],
      [this.inputsForm["pregunta3"], [Validadores.requerido]],
      [this.inputsForm["respuesta3"], [Validadores.requerido]],
      [this.inputsForm["estado"], [Validadores.requerido]],
      [this.inputsForm["municipio"], [Validadores.requerido]],
      [this.inputsForm["parroquia"], [Validadores.requerido]],
      [this.inputsForm["calle"], [Validadores.requerido]],
      [this.inputsForm["referencia"], [Validadores.requerido]],
    ];

    // Almacena el estado seleccionado para tener a la mano sus municipios
    this.estadoSeleccionado = null;

    // Para cada estado del json de direcciones agg una opcion
    // en el select correspondiente
    estados.forEach((estado, index) => {
      this.aggOption(this.inputsForm["estado"], estado.estado, index + 1);
    });

    // Cuando el usuario seleccione un estado, actualizar
    // los selects de municipios y parroquias
    this.inputsForm["estado"].addEventListener("input", () => {
      this.actMunicipios();
      this.actParroquias();
    });

    // Cuando el usuario seleccione un municipio, actualizar las parroquias
    this.inputsForm["municipio"].addEventListener("input", () => {
      this.actParroquias();
    });

    // Validar al hacer submit
    this.form.addEventListener("submit", async (e) => {
      e.preventDefault();

      // si el form es valido
      if (this.validarInputs(this.modeloForm)) {
        // obtener sus datos
        const datos = Object.fromEntries(new FormData(e.target));

        const conexion = new Conexion();

        // enviar la peticion para crear usuario
        const exito = await conexion.crearUsuario(datos);

        // si es exitosa redirige al login
        if (exito.status === 201) {
          this.form.reset();
          ToastService.crearToast("¡Registro exitoso!", { class: "success" });
          window.location.href = "/login";
          return;
        }

        ToastService.crearToast(exito.error, { class: "fail" });
      }
    });
  }

  // Actualizar las parroquias del select de parroquias
  actParroquias() {
    // Limpiar lo que pueda haber actualmente en el select
    Utilidades.eliminarNodosHijos(this.inputsForm["parroquia"]);

    // Recorrer los municipios del estado seleccionado
    for (let i = 0; i < this.estadoSeleccionado.municipios.length; i++) {
      const municipio = this.estadoSeleccionado.municipios[i];

      // Si el elemento actual del bucle coincide con
      // el municipio seleccionado en el select
      if (i + 1 == this.inputsForm["municipio"].value) {
        // Agg los options de cada parroquia
        municipio.parroquias.forEach((parroquia, index) => {
          this.aggOption(this.inputsForm["parroquia"], parroquia, index + 1);
        });
        break;
      }
    }
  }

  // Actualizar los municipios del select de municipios
  actMunicipios() {
    // Limpiar lo que pueda haber actualmente en el select
    Utilidades.eliminarNodosHijos(this.inputsForm["municipio"]);

    // Recorrer los municipios del estado seleccionado
    for (let i = 0; i < estados.length; i++) {
      const estado = estados[i];

      // Si el elemento actual del bucle coincide con
      // el estado seleccionado en el select
      if (i + 1 == this.inputsForm["estado"].value) {
        // Guardar el estado seleccionado para acceder facilmente
        // a sus municipios y a las parroquias de cada municipio
        this.estadoSeleccionado = estado;

        // Agg los options de cada municipio
        estado.municipios.forEach((municipio, index) => {
          this.aggOption(
            this.inputsForm["municipio"],
            municipio.municipio,
            index + 1
          );
        });
        break;
      }
    }
  }

  // Crea un elemento option y lo agg al select dado
  aggOption(select, contenido, valor) {
    const opcion = document.createElement("option");
    opcion.textContent = contenido;
    opcion.value = valor;
    select.appendChild(opcion);
  }

  // recorre un array de arrays, donde cada array contiene una ref a un input
  // y un array de validadores
  validarInputs(modeloForm) {
    // por defecto el form es valido hasta que se demuestre lo contrario
    let formValido = true;

    for (let i = 0; i < modeloForm.length; i++) {
      const modeloInput = modeloForm[i];

      // recorres los validadores
      for (let j = 0; j < modeloInput[1].length; j++) {
        const validador = modeloInput[1][j];

        // si no es valido, muestra el error y pasa a recorrer los validadores del sig input
        if (!validador(modeloInput[0].value)) {
          this.mostrarError(modeloInput[0]);

          // el form ya no es valido
          formValido = false;
          break;
        }

        // si el input cumple con todos sus validadores, borra sus errores
        this.borrarError(modeloInput[0]);
      }
    }
    return formValido;
  }

  // Coloca el msj de error en el elemento especificado
  // y le agg las clases de error activo
  mostrarError(input) {
    const contenedor = input.nextElementSibling;
    contenedor.className = "error active";
  }

  // Borra el msj de error en el elemento especificado
  // y le quita la clase active
  borrarError(input) {
    const contenedor = input.nextElementSibling;
    contenedor.className = "error";
  }
}
