import Ubicacion from "/scripts/envios/ubicacion.js";
import Utilidades from "/scripts/utilidades/utilidades.js";
import Transporte from "/scripts/envios/transporte.js";
import Envio from "/scripts/envios/envio.js";
import Paquete from "/scripts/envios/paquete.js";
import ServicioTransportes from "/scripts/api/transportes.js";
import ServicioUbicaciones from "/scripts/api/ubicaciones.js";

export default class CalculadoraCostosEnvios {
  constructor() {
    const svTrans = new ServicioTransportes();
    let transportes;

    const svUbi = new ServicioUbicaciones();
    let ubicaciones;

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

    // hacer peticion a la api, cuando se reciban los datos,
    // llena los selects de ubicaciones
    svUbi.obtUbicaciones().then((res) => {
      ubicaciones = res;
      Object.values(res).forEach((ubicacion) => {
        selectOrigen.appendChild(new Option(ubicacion.nombre, ubicacion.id));
        selectDestino.appendChild(new Option(ubicacion.nombre, ubicacion.id));
      });
    });

    // hacer peticion a la api, cuando se reciban los datos, llena el select de transportes
    svTrans.obtTransportes().then((res) => {
      transportes = res;
      Object.values(res).forEach((transporte) => {
        selectTransporte.appendChild(
          new Option(transporte.nombre, transporte.id)
        );
      });
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

      const transporteSeleccionado = Utilidades.buscarObjEnArray(
        selectTransporte.value,
        transportes
      );

      const origenSeleccionado = Utilidades.buscarObjEnArray(
        selectOrigen.value,
        ubicaciones
      );

      const destinoSeleccionado = Utilidades.buscarObjEnArray(
        selectDestino.value,
        ubicaciones
      );

      // Crear un objeto envio con los valores del form
      const envio = new Envio(
        paquete,
        origenSeleccionado,
        destinoSeleccionado,
        transporteSeleccionado
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
