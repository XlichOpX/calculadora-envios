export default class Navbar {
  static logeado() {
    const loginNav = document.querySelector(
      ".navbar-nav a[href='/login']"
    ).parentElement;
    loginNav.className = "oculto";

    const registroNav = document.querySelector(
      ".navbar-nav a[href='/registro']"
    ).parentElement;
    registroNav.className = "oculto";
  }

  static noLogeado() {
    const logoutNav = document.querySelector(
      ".navbar-nav a[href='/logout']"
    ).parentElement;
    logoutNav.className = "oculto";

    const enviosNav = document.querySelector(
      ".navbar-nav a[href='/envios']"
    ).parentElement;
    enviosNav.className = "oculto";
  }
}
