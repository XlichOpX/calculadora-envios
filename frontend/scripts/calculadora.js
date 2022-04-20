import Ubicacion from "./ubicacion.js";
import Utilidades from "./utilidades.js";
import Transporte from "./transporte.js";
import Envio from "./envio.js";
import Paquete from "./paquete.js";

export default class CalculadoraCostosEnvios {
  constructor() {
    this.inputs = document.getElementById("formulario").elements;
    // Obtener el input peso del paquete
    const inputPeso = this.inputs["peso"];

    // Obtener los inputs  de dimensiones del paquete
    const inputsDimensiones = [
      this.inputs["largo"],
      this.inputs["ancho"],
      this.inputs["alto"],
    ];

    // Obtener los selects del form
    const selectOrigen = this.inputs["select-origen"];
    const selectDestino = this.inputs["select-destino"];
    const selectTransporte = this.inputs["select-transporte"];

    // Obtener el input de ganancia
    const inputGanancia = this.inputs["ganancia"];

    // Obtener los recipientes para las salidas
    const recipientePrecio = document.getElementById("precio-calculado");
    const recipienteDistancia = document.getElementById("distancia-recorrida");
    const recipienteTiempoEstimado = document.getElementById("tiempo-estimado");

    // Agregar cada ubicación de la clase Ubicacion como options a cada select
    Object.values(Ubicacion.ubicaciones).forEach((ubicacion) => {
      // Convertir la primera letra de cada nombre en mayúsculas para mejor presentación
      const nombreEnMayuscula = Utilidades.primeraLetraMayuscula(
        ubicacion.nombre
      );
      selectOrigen.appendChild(new Option(nombreEnMayuscula, ubicacion.nombre));
      selectDestino.appendChild(
        new Option(nombreEnMayuscula, ubicacion.nombre)
      );
    });

    Object.values(Transporte.transportes).forEach((transporte) => {
      const nombreEnMayuscula = Utilidades.primeraLetraMayuscula(
        transporte.nombre
      );
      selectTransporte.appendChild(
        new Option(nombreEnMayuscula, transporte.nombre)
      );
    });

    // Obtener el form y escuchar al evento submit
    const form = document.getElementById("formulario");
    form.addEventListener("submit", (event) => {
      // Evitar que se recarge la página
      event.preventDefault();

      // Crear el array de dimensiones para el paquete
      let dimensiones = [];
      for (let i = 0; i < inputsDimensiones.length; i++) {
        dimensiones.push(inputsDimensiones[i].value);
      }

      // Crear un paquete
      let paquete = new Paquete(inputPeso.value, dimensiones);

      // Crear un objeto envio con los valores del form
      const envio = new Envio(
        paquete,
        Ubicacion.ubicaciones[selectOrigen.value],
        Ubicacion.ubicaciones[selectDestino.value],
        Transporte.transportes[selectTransporte.value],
        inputGanancia.value
      );

      // Mostrar el precio calculado
      recipientePrecio.textContent = `Costo del envío: $${envio.precio.toFixed(
        2
      )}`;
      recipienteDistancia.textContent = `Distancia a recorrer: ${envio.distancia.toFixed(
        2
      )} km`;
      recipienteTiempoEstimado.textContent = `Tiempo de recorrido estimado: ${envio.tiempoEstimado.toFixed(
        2
      )} horas`;
    });
  }
}
