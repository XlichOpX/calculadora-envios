import CalculadoraCostosEnvios from "./calculadora.js";
import Registro from "./registro.js";
import Utilidades from "./utilidades.js";
import Login from "./login.js";

// Por defecto iniciar en la vista de calculadora
Utilidades.cambiarVista("../views/login.html").then(() => {
  const login = new Login();
  login.iniciar();
});

// Al hacer click en un link de la navbar cambiar a la vista correspondiente
document.querySelectorAll(".navbar-nav a").forEach((link) => {
  link.addEventListener("click", (e) => {
    // Evita que se recargue la página
    e.preventDefault();

    // Cambiar a la vista referenciada en el atributo href del link clickeado
    Utilidades.cambiarVista(e.target.attributes.href.value).then(() => {
      switch (e.target.attributes.href.value) {
        case "./views/login.html": {
          const login = new Login();
          login.iniciar();
          break;
        }

        case "./views/calculadora.html": {
          const calculadora = new CalculadoraCostosEnvios();
          calculadora.iniciar();
          break;
        }

        case "./views/registro.html": {
          const registro = new Registro();
          registro.iniciar();
          break;
        }

        default: {
          console.log("Ruta inválida");
          break;
        }
      }
    });
  });
});
