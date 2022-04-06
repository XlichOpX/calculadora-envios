export default class Utilidades {
  static primeraLetraMayuscula(texto) {
    return texto.charAt(0).toUpperCase() + texto.slice(1)
  }

  static eliminarNodosHijos(elemento) {
    while (elemento.firstChild) {
      elemento.removeChild(elemento.firstChild)
    }
  }

  static cambiarVista = async function (urlVista) {
    await fetch(urlVista)
      .then((res) => res.text())
      .then((res) => {
        const vista = document.getElementById('vista')
        Utilidades.eliminarNodosHijos(vista)
        const nuevaVista = document.createElement('div')
        nuevaVista.innerHTML = res
        vista.appendChild(nuevaVista.firstChild)
      })
  }
}
