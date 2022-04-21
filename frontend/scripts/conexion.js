export default class Conexion {
  constructor() {
    this.baseUrl = "http://calc-envios.localhost:3000";
  }

  async crearUsuario(datos) {
    const peticion = new Request(`${this.baseUrl}/usuarios`);

    const opciones = { method: "POST", body: JSON.stringify(datos) };

    const resultado = await fetch(peticion, opciones);

    return resultado;
  }
}
