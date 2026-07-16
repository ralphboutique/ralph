import { Controller } from "@hotwired/stimulus"
import CartStore from "./cart_store"

export default class extends Controller {
  static targets = ["indicator", "count", "total", "subtotal", "form", "submitBtn", "cartList", "emptyMsg"]
  static values = {
    id: Number,
    title: String,
    price: Number,
    image: String,
    link: String,
    color: String,
    size: String
  }

  connect() {
    if (this.hasCartListTarget) {
      this.renderCart()
    }
  }

  // ========== ADD TO CART ==========

  add(event) {
    const btn = event.currentTarget
    const origHTML = btn.innerHTML
    btn.disabled = true
    btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i>'
    btn.classList.add('opacity-70')

    const item = {
      id: this.idValue,
      title: this.titleValue,
      price: this.priceValue,
      image: this.imageValue || '',
      link: this.linkValue || window.location.href,
      color: this.colorValue || this.selectedColor(),
      size: this.sizeValue || this.selectedSize(),
      quantity: parseInt(this.element.querySelector('[data-quantity-input]')?.value) || 1
    }

    CartStore.addToCart(item)
    this.showFeedback(btn, '✓ Agregado', origHTML)
    if (window.showToast) window.showToast(`${item.title} añadido al carrito`, 'success')
    this.updateUI()
  }

  // ========== CLEAR ==========

  clear() {
    if (CartStore.getCart().length === 0) return
    if (confirm('¿Vaciar carrito?')) {
      CartStore.clearCart()
      if (window.showToast) window.showToast('Carrito vaciado', 'error')
      this.updateUI()
      if (this.hasCartListTarget) this.renderCart()
    }
  }

  // ========== REMOVE / UPDATE ==========

  remove(event) {
    const idx = parseInt(event.currentTarget.dataset.index)
    const cart = CartStore.getCart()
    const item = cart[idx]
    CartStore.removeFromCart(idx)
    if (window.showToast && item) window.showToast(`${item.title} eliminado del carrito`, 'error')
    if (this.hasCartListTarget) this.renderCart()
    this.updateUI()
  }

  updateQty(event) {
    const index = parseInt(event.target.dataset.index)
    const qty = parseInt(event.target.value)
    CartStore.updateQuantity(index, qty)
    if (this.hasCartListTarget) this.renderCart()
    this.updateUI()
  }

  // ========== CART PAGE SPECIFIC ==========

  renderCart() {
    const cart = CartStore.getCart()
    const list = this.cartListTarget
    const empty = this.emptyMsgTarget
    if (!list) return

    if (cart.length === 0) {
      list.innerHTML = ''
      if (empty) empty.classList.remove('hidden')
      this.updateTotals()
      return
    }

    if (empty) empty.classList.add('hidden')

    list.innerHTML = ''

    cart.forEach((item, index) => {
      const subtotal = (parseFloat(item.price) * item.quantity).toFixed(2)
      const colorName = CartStore.getColorName ? CartStore.getColorName(item.color) : item.color
      const card = document.createElement('div')
      card.className = 'bg-white rounded-2xl shadow-sm border border-gray-100 p-4 hover:shadow-md transition-shadow duration-200'
      card.innerHTML = `
        <div class="flex gap-4">
          ${item.image ? `<img src="${item.image}" class="w-20 h-20 sm:w-24 sm:h-24 object-cover rounded-xl flex-shrink-0" onerror="this.style.display='none'">` : ''}
          <div class="flex-1 min-w-0">
            <div class="flex items-start justify-between gap-2">
              <div>
                <h3 class="font-semibold text-gray-900 text-sm sm:text-base">${item.title}</h3>
                ${colorName ? `<p class="text-xs text-gray-400 mt-0.5">Color: ${colorName}</p>` : ''}
                ${item.size ? `<p class="text-xs text-gray-400">Talla: ${item.size}</p>` : ''}
                ${item.link ? `<a href="${item.link}" class="text-xs text-purple-600 hover:text-purple-700 hover:underline mt-1 inline-block">Ver producto →</a>` : ''}
              </div>
              <button data-action="cart#remove" data-index="${index}"
                      class="text-gray-300 hover:text-red-500 transition-colors flex-shrink-0 p-1">
                <i class="fa-solid fa-xmark text-lg"></i>
              </button>
            </div>
            <div class="flex items-center justify-between mt-3 pt-3 border-t border-gray-50">
              <div class="flex items-center gap-2">
                <span class="text-sm text-gray-500">Cant:</span>
                <input type="number" value="${item.quantity}" min="1"
                       data-action="change->cart#updateQty" data-index="${index}"
                       class="w-14 px-2 py-1 text-sm text-center border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-300">
              </div>
              <div class="text-right">
                <p class="text-base font-bold text-gray-900">$${subtotal}</p>
                <p class="text-xs text-gray-400">$${parseFloat(item.price).toFixed(2)} c/u</p>
              </div>
            </div>
          </div>
        </div>
      `
      list.appendChild(card)
    })

    this.updateTotals()
  }

  updateTotals() {
    const total = CartStore.getCartTotal()
    const count = CartStore.getCartCount()

    this.countTargets.forEach(el => { el.textContent = count })

    if (this.hasSubtotalTarget) {
      this.subtotalTarget.textContent = `$${total.toFixed(2)}`
    }
    if (this.hasTotalTarget) {
      this.totalTarget.textContent = `$${total.toFixed(2)}`
    }
  }

  // ========== CHECKOUT ==========

  validateForm() {
    const name = this.element.querySelector('[name="customer_name"]')?.value?.trim()
    const lastName = this.element.querySelector('[name="customer_lastname"]')?.value?.trim()
    const phone = this.element.querySelector('[name="customer_phone"]')?.value?.trim()
    const address = this.element.querySelector('[name="customer_address"]')?.value?.trim()
    const btn = this.submitBtnTarget

    if (name && lastName && phone && address && CartStore.getCart().length > 0) {
      btn.disabled = false
      btn.classList.remove('opacity-50', 'cursor-not-allowed')
      btn.classList.add('hover:shadow-lg', 'hover:scale-105')
    } else {
      btn.disabled = true
      btn.classList.add('opacity-50', 'cursor-not-allowed')
      btn.classList.remove('hover:shadow-lg', 'hover:scale-105')
    }
  }

  checkout(event) {
    event.preventDefault()

    const cart = CartStore.getCart()
    if (cart.length === 0) return

    const customer = {
      name: this.element.querySelector('[name="customer_name"]')?.value?.trim() || '',
      lastName: this.element.querySelector('[name="customer_lastname"]')?.value?.trim() || '',
      phone: this.element.querySelector('[name="customer_phone"]')?.value?.trim() || '',
      address: this.element.querySelector('[name="customer_address"]')?.value?.trim() || ''
    }

    if (!customer.name || !customer.lastName || !customer.phone || !customer.address) return

    const message = CartStore.buildWhatsAppMessage(customer, cart)
    CartStore.openWhatsApp('584121075579', message)
    CartStore.clearCart()
    this.updateUI()
  }

  // ========== FAVORITES ==========

  toggleFav(event) {
    const id = parseInt(event.currentTarget.dataset.id || this.idValue)
    CartStore.toggleFavorite(id)

    const icon = event.currentTarget.querySelector('i')
    if (icon) {
      if (CartStore.isFavorite(id)) {
        icon.className = 'fas fa-heart text-red-500'
      } else {
        icon.className = 'far fa-heart'
      }
    }

    if (window.updateFavBadge) window.updateFavBadge()
    this.updateUI()
  }

  // ========== HELPERS ==========

  selectedColor() {
    const el = this.element.querySelector('button.ring-2.ring-indigo-500')
    if (el) return el.dataset.colorHex || el.title || ''
    return ''
  }

  selectedSize() {
    const el = this.element.querySelector('button.bg-indigo-100')
    if (el) return el.textContent?.trim() || ''
    return ''
  }

  showFeedback(btn, text, origHTML) {
    btn.innerHTML = text
    btn.classList.remove('opacity-70')
    btn.classList.add('bg-green-600')
    setTimeout(() => {
      btn.innerHTML = origHTML || text
      btn.disabled = false
      btn.classList.remove('bg-green-600')
    }, 1500)
  }

  updateUI() {
    CartStore.notify()
  }
}
