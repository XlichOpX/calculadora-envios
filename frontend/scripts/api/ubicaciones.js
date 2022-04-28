import Conexion from "./conexion.js";

export default class ServicioUbicaciones extends Conexion {
  obtUbicaciones() {
    return this.peticion("/ubicaciones", "GET");
  }
}
