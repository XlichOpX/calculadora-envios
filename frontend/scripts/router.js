import Calculadora from "./calculadora.js";
import Login from "./login.js";
import Registro from "./registro.js";
import Autenticacion from "./autenticacion.js";

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
  404: { path: "/views/login.html", disparador: Login },
  "/": { path: "/views/login.html", disparador: Login },
  "/calculadora": {
    path: "/views/calculadora.html",
    disparador: Calculadora,
    bloqueada: true,
  },
  "/login": { path: "/views/login.html", disparador: Login },
  "/registro": { path: "/views/registro.html", disparador: Registro },
};

const manejarUbicacion = async () => {
  // obtener la ruta a la que se intenta acceder
  const path = window.location.pathname;

  // asociarla con una de las rutas de la app o en su defecto la ruta 404
  let ruta = rutas[path] || rutas[404];

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

  // ejecutar el constructor del objeto que maneja la vista para iniciar su JS
  new ruta.disparador();
};

// manejar el routing cuando el usuario usa los botones de ir atras o adelante
window.onpopstate = manejarUbicacion;

// hacer que el router sea accesible globalmente
window.route = enrutar;

// manejar la ubicacion por primera vez al iniciar la app
manejarUbicacion();
