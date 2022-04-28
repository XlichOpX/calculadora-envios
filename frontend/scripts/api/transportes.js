import Conexion from "./conexion.js";

export default class ServicioTransportes extends Conexion {
  async obtTransportes() {
    const resultado = await this.peticion("/transportes", "GET");
    return resultado;
  }
}
