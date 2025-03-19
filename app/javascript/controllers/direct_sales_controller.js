import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["saleItems", "totalPrice"]

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

    console.log(`Total: ${total.toFixed(2)}`);

    this.totalPriceTarget.textContent = total.toFixed(2);
  }

  updatePrice(event) {
    const select = event.target;
    const selectedOption = select.options[select.selectedIndex];
    const price = selectedOption.dataset.price || 0;
    const saleItem = select.closest(".sale-item");
    const priceInput = saleItem.querySelector(".price-input");
    
    priceInput.value = parseFloat(price).toFixed(2);
    priceInput.setAttribute("readonly", true);
    
    this.updateTotal();
  }

  removeItem(event) {
    event.target.closest(".sale-item").remove();
    this.updateTotal();
  }
  updateQuantity(event) {
    const select = event.target;
    const selectedOption = select.options[select.selectedIndex];
    const availableQuantity = selectedOption.dataset.quantity || 0;
  
    const saleItem = select.closest(".sale-item");
    let quantitySpan = saleItem.querySelector(".available-quantity");
  
    if (quantitySpan) {
      quantitySpan.textContent = `Disponible: ${availableQuantity}`;
    }
  }
  validateQuantity(event) {
    const quantityInput = event.target;
    const saleItem = quantityInput.closest(".sale-item");
    const select = saleItem.querySelector(".article-select");
    const selectedOption = select.options[select.selectedIndex];
    const availableQuantity = parseInt(selectedOption.dataset.quantity) || 0;
    const errorMessage = saleItem.querySelector(".error-message");
  
    let enteredQuantity = parseInt(quantityInput.value);
  
    if (enteredQuantity > availableQuantity) {
      errorMessage.textContent = `Solo hay ${availableQuantity} unidades disponibles.`;
      errorMessage.classList.remove("hidden");
      quantityInput.value = "";
    } else {
      errorMessage.classList.add("hidden");
    }
  }

  validateDuplicateArticle(event) {
    const select = event.target;
    const selectedValue = select.value;
  
    if (!selectedValue) return; // No hacer nada si no hay selección
  
    const saleItems = this.saleItemsTarget.querySelectorAll(".article-select");
    let count = 0;
  
    saleItems.forEach((item) => {
      if (item.value === selectedValue) {
        count++;
      }
    });
  
    if (count > 1) {
      alert("Este artículo ya ha sido seleccionado.");
      select.value = "";
      const saleItem = select.closest(".sale-item");
      saleItem.querySelector(".quantity-input").value = 1; 
      saleItem.querySelector(".price-input").value = ""; 
      const availableQuantity = saleItem.querySelector(".available-quantity");
      if (availableQuantity) {
        availableQuantity.textContent = "Disponible: -";
      }

    }
  }

  addItem() {
    const saleItemsContainer = this.saleItemsTarget;
    const firstItem = saleItemsContainer.querySelector(".sale-item");
  
    if (firstItem) {
      const newItem = firstItem.cloneNode(true);
  
      newItem.querySelectorAll("input, select").forEach((el) => {
        if (el.tagName === "INPUT") {
          el.value = "";
        } else if (el.tagName === "SELECT") {
          el.selectedIndex = 0; // Restablecer selección
        }
      });
  
      // Vaciar la cantidad disponible
      const availableQuantitySpan = newItem.querySelector(".available-quantity");
      if (availableQuantitySpan) {
        availableQuantitySpan.textContent = "Disponible: -";
      }
  
      saleItemsContainer.appendChild(newItem);
      this.updateItemNames();
      this.updateTotal(); // Actualizar el total tras agregar un nuevo ítem
    } else {
      console.error("No hay elementos para clonar.");
    }
  }
  

  updateItemNames() {
    this.saleItemsTarget.querySelectorAll(".sale-item").forEach((item, index) => {
      const articleSelect = item.querySelector(".article-select");
      const quantityInput = item.querySelector(".quantity-input");
      const priceInput = item.querySelector(".price-input");

      if (articleSelect) articleSelect.name = `sale[sale_items_attributes][${index}][article_id]`;
      if (quantityInput) quantityInput.name = `sale[sale_items_attributes][${index}][quantity]`;
      if (priceInput) priceInput.name = `sale[sale_items_attributes][${index}][price]`;
    });
  }
}
