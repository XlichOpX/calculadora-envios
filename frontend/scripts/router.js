import Calculadora from "/views/calculadora/calculadora.js";
import Login from "/views/login/login.js";
import Registro from "/views/registro/registro.js";
import Autenticacion from "./autenticacion.js";
import Logout from "/views/logout/logout.js";
import Navbar from "./navbar.js";
import RecuperarClave from "/views/recuperar-clave/recuperar-clave.js";

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
    path: "/views/calculadora/calculadora.html",
    nombre: "Calculadora",
    disparador: Calculadora,
    bloqueada: true,
  },
  "/login": {
    path: "/views/login/login.html",
    nombre: "Iniciar sesión",
    disparador: Login,
  },
  "/logout": {
    path: "/views/logout/logout.html",
    nombre: "Cerrando sesión",
    disparador: Logout,
  },
  "/registro": {
    path: "/views/registro/registro.html",
    nombre: "Registro",
    disparador: Registro,
  },
  "/recuperar-clave": {
    path: "/views/recuperar-clave/recuperar-clave.html",
    nombre: "Recuperar clave",
    disparador: RecuperarClave,
  },
};

const manejarUbicacion = async () => {
  // obtener la ruta a la que se intenta acceder
  const path = window.location.pathname;

  // asociarla con una de las rutas de la app o en su defecto la ruta 404
  let ruta = rutas[path] || rutas[404];

  const tokenValido = await Autenticacion.validarToken();

  if (!tokenValido) {
    // mostrar registro y login, esconder logout
    Navbar.noLogeado();

    if (path !== "/login" && ruta.bloqueada) {
      window.location.href = "/login";
      return;
    }
  } else {
    // esconder registro y login de la navbar
    Navbar.logeado();
  }

  // si la ruta es el login y el usuario esta logeado con un token valido
  // se le redirige a la calculadora
  if (path === "/login" && tokenValido) {
    window.location.href = "/calculadora";
    return;
  }

  // si la ruta esta config para redirigir a otra, redirige a la ruta especificada
  if (ruta.redirigir) {
    window.location.href = ruta.redirigir;
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
