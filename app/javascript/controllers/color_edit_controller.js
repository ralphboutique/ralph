
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container"];

  connect() {
    console.log("Color edit controller connected.");

    // Precargar colores si los hay
    if (Array.isArray(this.existingColors)) {
      this.existingColors.forEach(color => this.addColor(color));
    }
  }

  get existingColors() {
    // Obtener colores desde un atributo data
    const colors = this.data.get("colors");
    return colors ? JSON.parse(colors) : [];
  }

  addColor(value = "") {
    const colorDiv = document.createElement("div");
    colorDiv.classList.add("flex", "items-center", "space-x-2");

    const colorInput = document.createElement("input");
    colorInput.type = "color";
    colorInput.name = "article[colors][]";
    colorInput.value = value; // Establece el valor inicial
    colorInput.classList.add("border", "rounded", "w-12", "h-12");

    const removeButton = document.createElement("button");
    removeButton.type = "button";
    
    // Agrega el ícono al botón
    const icon = document.createElement("i");
    icon.classList.add("fa", "fa-trash", "text-red-500"); // Agrega las clases de Font Awesome
    removeButton.appendChild(icon);
    
    // Agrega estilos al botón
    removeButton.classList.add("hover:text-red-700", "font-bold", "py-1", "px-2", "rounded", "flex", "items-center", "justify-center");
    
    removeButton.addEventListener("click", () => {
      colorDiv.remove();
    });

    colorDiv.appendChild(colorInput);
    colorDiv.appendChild(removeButton);
    this.containerTarget.appendChild(colorDiv);
  }
}
