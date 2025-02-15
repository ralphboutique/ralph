import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["saleItems"]

  connect() {
    this.updateTotal()
  }

  updateTotal() {
    let total = 0;
    this.saleItemsTarget.querySelectorAll(".sale-item").forEach((item) => {
      const quantity = parseFloat(item.querySelector(".quantity-input").value) || 0;
      const price = parseFloat(item.querySelector(".price-input").value) || 0;
      total += quantity * price;
    });
  
    // Muestra el total en la consola para depuración
    console.log(`Total: ${total.toFixed(2)}`);
  
    // Si tienes un elemento en la vista para mostrar el total, actualízalo:
    const totalField = document.querySelector("#total-price");
    if (totalField) {
      totalField.textContent = total.toFixed(2);
    }
  }
  

    
  updatePrice(event) {
    const select = event.target
    const selectedOption = select.options[select.selectedIndex]
    const price = selectedOption.dataset.price || 0

    const saleItem = select.closest(".sale-item")
    const priceInput = saleItem.querySelector(".price-input")

    priceInput.value = parseFloat(price).toFixed(2)
    priceInput.setAttribute("disabled", true) // Bloquear edición manual

    this.updateTotal()
  }

  removeItem(event) {
    event.target.closest(".sale-item").remove()
    this.updateTotal()
  }

  addItem() {
    const saleItemsContainer = this.saleItemsTarget
    const newItem = saleItemsContainer.firstElementChild.cloneNode(true)

    // Reset fields
    newItem.querySelector(".article-select").selectedIndex = 0
    newItem.querySelector(".quantity-input").value = 1
    newItem.querySelector(".price-input").value = 0

    saleItemsContainer.appendChild(newItem)
  }
}
