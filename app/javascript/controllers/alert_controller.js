import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // Accede directamente al elemento del controlador
    const alertMessage = this.element;

    // Si quieres asegurarte de que el elemento tiene el ID correcto, puedes verificarlo (aunque no es necesario si tienes el controlador en el HTML).
    if (alertMessage.id === "alert-message") {
      setTimeout(() => {
        alertMessage.style.transition = "opacity 0.5s ease-out";
        alertMessage.style.opacity = 0;

        setTimeout(() => {
          alertMessage.remove(); // Elimina el mensaje del DOM después de la animación
        }, 500); // Tiempo de duración de la animación
      }, 3000); // Tiempo antes de desaparecer (3 segundos)
    }
  }
}
