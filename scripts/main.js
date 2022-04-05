import CalculadoraCostosEnvios from "./calculadora.js";
import Utilidades from "./utilidades.js";

// Por defecto iniciar en la vista de calculadora
Utilidades.cambiarVista("../views/calculadora.html").then(() => {
  let calculadora = new CalculadoraCostosEnvios();
  calculadora.iniciar();
});

// Al hacer click en un link de la navbar cambiar a la vista correspondiente
document.querySelectorAll(".navbar-nav a").forEach((link) => {
  link.addEventListener("click", (e) => {
    // Evita que se cambie por completo de página
    e.preventDefault();

    // Cambiar a la vista referenciada en el atributo href del link clickeado
    Utilidades.cambiarVista(e.target.attributes.href.value).then(() => {
      if (e.target.attributes.href.value === "./views/calculadora.html") {
        let calculadora = new CalculadoraCostosEnvios();
        calculadora.iniciar();
      }
    });
  });
});
