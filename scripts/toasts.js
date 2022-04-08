export default class ToastService {
  static crearToast(msj) {
    const toast = document.createElement("div");
    toast.textContent = msj;
    toast.className = "toast";
    document.getElementById("vista").appendChild(toast);
    setTimeout(() => {
      document.getElementById("vista").removeChild(toast);
    }, 5000);
  }
}
