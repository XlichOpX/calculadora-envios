export default class ToastService {
  static crearToast(msj, options = { class: "success" }) {
    const toast = document.createElement("div");
    toast.textContent = msj;
    toast.className = "toast " + options.class;
    document.body.appendChild(toast);
    setTimeout(() => {
      document.body.removeChild(toast);
    }, 5000);
  }
}
