import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "saleId", "installments", "paidInstallments", "pendingInstallments"];

  connect() {
    console.log("connect");
    document.body.addEventListener("click", (event) => {
      if (event.target.matches("[data-action='click->installment#open']")) {
        this.open(event);
      }
    });

    // Crear mensaje de error y agregarlo antes del input
    this.errorMessage = document.createElement("p");
    this.errorMessage.classList.add("text-red-600", "mt-2", "hidden");
    this.installmentsTarget.insertAdjacentElement("beforebegin", this.errorMessage);
  }

  open(event) {
    const button = event.target; 
    console.log("Evento open activado");
    console.log("Dataset completo:", button.dataset);

    const saleId = button.dataset.installmentSaleId;
    const installments = button.dataset.installmentSaleInstallments;
    const paidInstallments = button.dataset.installmentSalePaid;
    
    console.log("saleId:", saleId);
    console.log("installments:", installments);
    console.log("paidInstallments (antes de parseInt):", paidInstallments);

    if (!paidInstallments || !installments) {
      console.error("Error: paidInstallments o totalInstallments es undefined o vacío.");
    }
    
    const paid = parseInt(paidInstallments, 10) || 0;
    const pending = installments - paid;
    console.log("Cuotas pendientes (después de parseInt):", pending);

    this.saleIdTarget.textContent = saleId;
    this.paidInstallmentsTarget.textContent = paid;
    this.pendingInstallmentsTarget.textContent = pending;
    this.installmentsTarget.value = ""; // Resetear input al abrir modal
    this.errorMessage.classList.add("hidden"); // Esconder mensaje de error
    this.containerTarget.classList.remove("hidden");
  }

  close() {
    this.containerTarget.classList.add("hidden");
  }

  validate() {
    const pendingInstallments = parseInt(this.pendingInstallmentsTarget.textContent, 10);
    const enteredInstallments = parseInt(this.installmentsTarget.value, 10);

    if (enteredInstallments > pendingInstallments) {
      this.errorMessage.textContent = "La cantidad ingresada es mayor a las cuotas pendientes.";
      this.errorMessage.classList.remove("hidden");
      this.installmentsTarget.value = ""; // Vaciar el input
    } else {
      this.errorMessage.classList.add("hidden");
    }
  }

  async update(event) {
    event.preventDefault();
    const saleId = this.saleIdTarget.textContent;
    const installments = parseInt(this.installmentsTarget.value, 10);

    if (!installments || isNaN(installments)) {
      alert("Ingrese un número válido");
      return;
    }

    const response = await fetch(`/credit_sales/${saleId}/pay_installment`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({ installments })
    });

    if (response.ok) {
      alert("Cuota actualizada correctamente");
      this.close();
      location.reload();
    } else {
      alert("Error al actualizar la cuota");
    }
  }
}
