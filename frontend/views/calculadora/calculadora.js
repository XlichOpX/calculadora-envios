import Ubicacion from "/scripts/envios/ubicacion.js";
import Utilidades from "/scripts/utilidades/utilidades.js";
import Transporte from "/scripts/envios/transporte.js";
import Envio from "/scripts/envios/envio.js";
import Paquete from "/scripts/envios/paquete.js";
import Autenticacion from "/scripts/api/autenticacion.js";

export default class CalculadoraCostosEnvios {
  constructor() {
    this.formCalc = document.getElementById("formCalc");
    this.datosFormCalc = null;
    this.datosFormAgendar = null;

    // Obtener los selects del form para calcular
    const selectOrigen = this.formCalc.elements["select-origen"];
    const selectDestino = this.formCalc.elements["select-destino"];
    const selectTransporte = this.formCalc.elements["select-transporte"];

    // Obtener los contenedores para los resultados
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

    formCalc.addEventListener("submit", (e) => {
      // Evitar que se recarge la página
      e.preventDefault();

      // Crear objeto con los datos del form
      this.datosFormCalc = Object.fromEntries(new FormData(this.formCalc));

      // Crear el array de dimensiones para el paquete
      const dimensiones = [
        this.datosFormCalc["alto"],
        this.datosFormCalc["ancho"],
        this.datosFormCalc["largo"],
      ];

      // Crear un paquete
      const paquete = new Paquete(this.datosFormCalc["peso"], dimensiones);

      // Crear un objeto envio con los valores del form
      const envio = new Envio(
        paquete,
        Ubicacion.ubicaciones[this.datosFormCalc["origen"]],
        Ubicacion.ubicaciones[this.datosFormCalc["destino"]],
        Transporte.transportes[this.datosFormCalc["transporte"]]
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

      // mostrar el div de resultados
      document.getElementById("resultado").style = "";
    });

    const formAgendar = document.getElementById("formAgendar");
    formAgendar.addEventListener("submit", (e) => {
      e.preventDefault();

      this.datosFormAgendar = Object.fromEntries(new FormData(formAgendar));

      const datos = Object.assign(
        {},
        this.datosFormCalc,
        this.datosFormAgendar
      );

      console.log("Aqui se haria una request al back con estos datos", datos);
    });
  }
}
