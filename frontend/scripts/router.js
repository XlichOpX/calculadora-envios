import Calculadora from "./calculadora.js";
import Login from "./login.js";
import Registro from "./registro.js";
import Autenticacion from "./autenticacion.js";
import Logout from "./logout.js";

// agg listeners a los links de la nav
document.querySelectorAll(".navbar-nav a").forEach((enlace) => {
  enlace.addEventListener("click", (e) => {
    enrutar(e);
  });
});

// usada para enrutar desde los links
const enrutar = (event) => {
  event = event || window.event;

  // evita que se recargue la pagina
  event.preventDefault();

  // agg la url al historial del usuario
  window.history.pushState({}, "", event.target.href);

  // finalmente, maneja la ubicacion que se desea acceder
  manejarUbicacion();
};

// rutas de la app
const rutas = {
  404: { path: "/views/404.html", nombre: "404 - Página no encontrada" },
  "/": {
    redirigir: "/calculadora",
  },
  "/calculadora": {
    path: "/views/calculadora.html",
    nombre: "Calculadora",
    disparador: Calculadora,
    bloqueada: true,
  },
  "/login": {
    path: "/views/login.html",
    nombre: "Iniciar sesión",
    disparador: Login,
  },
  "/logout": {
    path: "/views/logout.html",
    nombre: "Cerrando sesión",
    disparador: Logout,
  },
  "/registro": {
    path: "/views/registro.html",
    nombre: "Registro",
    disparador: Registro,
  },
};

const manejarUbicacion = async () => {
  // obtener la ruta a la que se intenta acceder
  const path = window.location.pathname;

  // asociarla con una de las rutas de la app o en su defecto la ruta 404
  let ruta = rutas[path] || rutas[404];

  // si la ruta esta config para redirigir a otra, redirige a la ruta especificada
  if (ruta.redirigir) {
    window.location.href = ruta.redirigir;
    return;
  }

  // si la ruta esta bloqueada, verifica que el usuario este logeado para acceder
  const restringido = ruta.bloqueada && !(await Autenticacion.validarToken());

  // si el usuario no esta logeado, se le redirige al login
  if (restringido) {
    window.location.href = "/login";
    return;
  }

  // obtener el html de la ruta a la que se desea acceder
  const html = await fetch(ruta.path).then((data) => data.text());

  // introducirlo a la vista
  document.getElementById("vista").innerHTML = html;

  // poner el nombre de la ruta en el title de la pag
  document.title = ruta.nombre;

  // ejecutar el constructor del objeto que maneja la vista para iniciar su JS
  if (ruta.disparador) {
    new ruta.disparador();
  }
};

// manejar el routing cuando el usuario usa los botones de ir atras o adelante
window.onpopstate = manejarUbicacion;

// manejar la ubicacion por primera vez al iniciar la app
manejarUbicacion();
