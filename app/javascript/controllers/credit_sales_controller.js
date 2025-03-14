import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["saleItems", "totalPrice", "installmentAmount", "installments"];

  connect() {
    this.updateTotal();
  }

  updateTotal() {
    let total = 0;
    this.saleItemsTarget.querySelectorAll(".sale-item").forEach((item) => {
      const quantity = parseFloat(item.querySelector(".quantity-input").value) || 0;
      const price = parseFloat(item.querySelector(".price-input").value) || 0;
      total += quantity * price;
    });

    this.totalPriceTarget.textContent = total.toFixed(2);
    this.updateInstallments();
  }

  updatePrice(event) {
    const select = event.target;
    const selectedOption = select.options[select.selectedIndex];
    const price = selectedOption.dataset.price || 0;

    const saleItem = select.closest(".sale-item");
    const priceInput = saleItem.querySelector(".price-input");

    priceInput.value = parseFloat(price).toFixed(2);
    priceInput.setAttribute("readonly", true) 
    this.updateTotal();
  }

  removeItem(event) {
    event.target.closest(".sale-item").remove();
    this.updateTotal();
  }
  updateInstallments() {
    const total = parseFloat(this.totalPriceTarget.textContent.trim()) || 0;
    const installments = parseInt(this.installmentsTarget.value.trim()) || 1;

    if (installments > 0) {
      const amountPerInstallment = total / installments;
      this.installmentAmountTarget.textContent = amountPerInstallment.toFixed(2);
    } else {
      this.installmentAmountTarget.textContent = "0.00";
    }
  }
  addItem() {
    const saleItemsContainer = this.saleItemsTarget;
    const firstItem = saleItemsContainer.querySelector(".sale-item");
  
    if (firstItem) {
      const newItem = firstItem.cloneNode(true);
  
      // Limpiar los valores de los inputs y selects
      newItem.querySelectorAll("input, select").forEach((el) => {
        if (el.tagName === "INPUT") {
          el.value = el.type === "number" ? 1 : ""; // Si es número, poner 1 por defecto
        } else if (el.tagName === "SELECT") {
          el.selectedIndex = 0; // Reiniciar el select
        }
      });
  
      // Insertar el nuevo item después del primer elemento existente
      saleItemsContainer.insertBefore(newItem, firstItem.nextSibling);
  
      // Actualizar nombres de los inputs para mantener coherencia con Rails
      this.updateItemNames();
      this.updateTotal();
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