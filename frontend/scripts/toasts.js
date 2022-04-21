export default class ToastService {
  static crearToast(msj) {
    const toast = document.createElement("div");
    toast.textContent = msj;
    toast.className = "toast";
    document.firstElementChild.appendChild(toast);
    setTimeout(() => {
      document.firstElementChild.removeChild(toast);
    }, 5000);
  }
}
