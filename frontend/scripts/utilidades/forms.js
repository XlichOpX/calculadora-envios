export default class ModeloForm {
  constructor(modeloForm) {
    this.modeloForm = modeloForm;
  }

  validarInputs() {
    // por defecto el form es valido hasta que se demuestre lo contrario
    let formValido = true;

    for (let i = 0; i < this.modeloForm.length; i++) {
      const modeloInput = this.modeloForm[i];

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
