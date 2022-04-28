import Conexion from "./conexion.js";

export default class ServicioEnvios extends Conexion {
  crearEnvio(datos) {
    return this.peticion("/envios", "POST", datos);
  }
}
