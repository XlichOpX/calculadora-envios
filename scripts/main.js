import CalculadoraCostosEnvios from "./calculadora.js";
import Utilidades from "./utilidades.js";

Utilidades.cambiarVista("../views/calculadora.html").then(() => {
  let calculadora = new CalculadoraCostosEnvios();
  calculadora.iniciar();
});
