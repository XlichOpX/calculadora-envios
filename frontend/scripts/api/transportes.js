import Conexion from "./conexion.js";

export default class ServicioTransportes extends Conexion {
  obtTransportes() {
    return this.peticion("/transportes", "GET");
  }
}
