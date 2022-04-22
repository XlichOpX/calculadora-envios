export default class Conexion {
  constructor() {
    this.baseUrl = "http://calc-envios.localhost:3000";
  }

  async peticion(endpoint, metodo, datos) {
    const peticion = new Request(`${this.baseUrl}/${endpoint}`);
    const opciones = { method: metodo, body: JSON.stringify(datos) };
    const resultado = await fetch(peticion, opciones)
      .then((res) => res.json())
      .then((res) => res);
    return resultado;
  }

  async crearUsuario(datos) {
    const peticion = new Request(`${this.baseUrl}/usuarios`);

    const opciones = { method: "POST", body: JSON.stringify(datos) };

    const resultado = await fetch(peticion, opciones)
      .then((res) => res.json())
      .then((res) => res);

    return resultado;
  }
}
