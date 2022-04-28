export default class Conexion {
  constructor() {
    this.baseUrl = "http://calc-envios.localhost:3000";
  }

  peticion(endpoint, metodo, datos = null) {
    const peticion = new Request(`${this.baseUrl}/${endpoint}`);
    const opciones = {
      method: metodo,
      body: datos ? JSON.stringify(datos) : null,
    };
    const resultado = fetch(peticion, opciones)
      .then((res) => res.json())
      .then((res) => res);
    return resultado;
  }

  async crearUsuario(datos) {
    const peticion = new Request(`${this.baseUrl}/usuarios`);

    const opciones = {
      method: "POST",
      body: JSON.stringify(datos),
    };

    const resultado = await fetch(peticion, opciones)
      .then((res) => res.json())
      .then((res) => res);

    return resultado;
  }
}
