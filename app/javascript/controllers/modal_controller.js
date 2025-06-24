import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "saleId", "saleName", "salePayment", "saleDate", "salePrice", "saleArticles"]

  connect() {
    console.log("Modal controller conectado correctamente");
    document.body.addEventListener("click", (event) => {
      if (event.target.matches("[data-action='click->modal#open']")) {
        this.open(event);
      }
    });
  }

  open(event) {
    console.log("Abriendo modal...");
    const button = event.target; 
    console.log("Datos del botón:", button.dataset);

    // Asignar valores de texto simples
    this.saleIdTarget.textContent = button.dataset.modalSaleId;
    this.saleNameTarget.textContent = button.dataset.modalSaleName;
    this.salePaymentTarget.textContent = button.dataset.modalSalePayment;
    this.saleDateTarget.textContent = button.dataset.modalSaleDate;

    // Limpiar lista de artículos
    let articlesList = this.saleArticlesTarget;
    articlesList.innerHTML = ""; 

    try {
      // Parsear JSON de artículos y precios
      let articles = JSON.parse(button.dataset.modalSaleArticles || "[]");
      let prices = JSON.parse(button.dataset.modalSalePrice || "[]");

      let totalPrice = 0;

      articles.forEach((article, index) => {
        let li = document.createElement("li");
        let price = parseFloat(prices[index]) || 0;
        let quantity = article.quantity || 1; // Si no hay cantidad, asumir 1

        totalPrice += price * quantity; // Multiplicar por cantidad

        li.textContent = `${article.title} (x${quantity}) - $${(price * quantity).toFixed(2)}`;
        articlesList.appendChild(li);
      });

      // Mostrar la suma total de los precios
      this.salePriceTarget.textContent = `Total: $${totalPrice.toFixed(2)}`;
    } catch (error) {
      console.error("Error al parsear los datos de la venta:", error);
    }

    // Mostrar el modal
    this.containerTarget.classList.remove("hidden");
  }

  close() {
    console.log("Cerrando modal...");
    this.containerTarget.classList.add("hidden");
  }
}
