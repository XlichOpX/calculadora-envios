export default class ToastService {
  static crearToast(msj) {
    const toast = document.createElement("div");
    toast.textContent = msj;
    toast.className = "toast";
    document.body.appendChild(toast);
    setTimeout(() => {
      document.body.removeChild(toast);
    }, 5000);
  }
}
