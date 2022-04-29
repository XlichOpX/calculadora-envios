import ServicioEnvios from "../../scripts/api/envios.js";

export default class Envios {
  constructor() {
    const tableBody = document.querySelector("#tableBody");
    const svEnvios = new ServicioEnvios();

    svEnvios.obtEnvios().then((res) => {
      if (res.error) {
        tableBody.innerHTML += `<tr><td colspan="4">No tienes ningún envío agendado...</td></tr>`;
      } else {
        res.forEach((envio) => {
          tableBody.innerHTML += `<tr>
        <td>${envio.num_tracking}</td>
        <td>${envio.estatus}</td>
        <td>${envio.origen}</td>
        <td>${envio.destino}</td>
        </tr>`;
        });
      }
    });
  }
}
