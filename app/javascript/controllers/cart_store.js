const CART_KEY = 'ralph_cart'
const FAVORITES_KEY = 'ralph_favorites'

const COLOR_NAMES = {
  '#FF0000': 'Rojo', '#FF4500': 'Naranja', '#FF8C00': 'Naranja oscuro',
  '#FFD700': 'Dorado', '#FFFF00': 'Amarillo', '#ADFF2F': 'Verde amarillento',
  '#00FF00': 'Verde', '#008000': 'Verde oscuro', '#00FFFF': 'Cian',
  '#0000FF': 'Azul', '#000080': 'Azul marino', '#4B0082': 'Índigo',
  '#800080': 'Púrpura', '#FF00FF': 'Magenta', '#FFC0CB': 'Rosa',
  '#FF69B4': 'Rosa fuerte', '#A52A2A': 'Marrón', '#8B4513': 'Marrón oscuro',
  '#000000': 'Negro', '#333333': 'Gris oscuro', '#666666': 'Gris',
  '#999999': 'Gris claro', '#CCCCCC': 'Gris muy claro', '#FFFFFF': 'Blanco',
  '#F5F5F5': 'Blanco humo', '#C0C0C0': 'Plata', '#FFDAB9': 'Durazno',
  '#E6E6FA': 'Lavanda', '#DDA0DD': 'Ciruela', '#98FB98': 'Verde claro',
  '#87CEEB': 'Celeste', '#B0C4DE': 'Azul claro', '#F0E68C': 'Caqui',
  '#D2691E': 'Chocolate', '#FA8072': 'Salmón', '#FF6347': 'Tomate',
  '#40E0D0': 'Turquesa', '#48D1CC': 'Turquesa medio', '#00CED1': 'Turquesa oscuro',
}

function getColorName(hex) {
  if (!hex) return ''
  const clean = hex.toUpperCase()
  if (COLOR_NAMES[clean]) return COLOR_NAMES[clean]
  if (COLOR_NAMES['#' + clean.replace('#', '')]) return COLOR_NAMES['#' + clean.replace('#', '')]
  return hex
}

const CartStore = {
  getColorName,
  // ========== CART ==========

  getCart() {
    try {
      return JSON.parse(localStorage.getItem(CART_KEY)) || []
    } catch {
      return []
    }
  },

  saveCart(cart) {
    localStorage.setItem(CART_KEY, JSON.stringify(cart))
    this.notify()
  },

  addToCart(item) {
    const cart = this.getCart()
    const key = `${item.id}-${item.color || ''}-${item.size || ''}`
    const existing = cart.find(i => `${i.id}-${i.color || ''}-${i.size || ''}` === key)
    if (existing) {
      existing.quantity = (existing.quantity || 1) + (item.quantity || 1)
    } else {
      cart.push({ ...item, quantity: item.quantity || 1 })
    }
    this.saveCart(cart)
    return cart
  },

  removeFromCart(index) {
    const cart = this.getCart()
    cart.splice(index, 1)
    this.saveCart(cart)
    return cart
  },

  updateQuantity(index, quantity) {
    const cart = this.getCart()
    if (quantity <= 0) {
      cart.splice(index, 1)
    } else {
      cart[index].quantity = quantity
    }
    this.saveCart(cart)
    return cart
  },

  clearCart() {
    localStorage.removeItem(CART_KEY)
    this.notify()
    return []
  },

  getCartCount() {
    return this.getCart().reduce((sum, item) => sum + (item.quantity || 0), 0)
  },

  getCartTotal() {
    return this.getCart().reduce((sum, item) => sum + (parseFloat(item.price) * (item.quantity || 0)), 0)
  },

  // ========== FAVORITES ==========

  getFavorites() {
    try {
      return JSON.parse(localStorage.getItem(FAVORITES_KEY)) || []
    } catch {
      return []
    }
  },

  saveFavorites(favs) {
    localStorage.setItem(FAVORITES_KEY, JSON.stringify(favs))
    this.notify()
  },

  toggleFavorite(productId) {
    const favs = this.getFavorites()
    const index = favs.indexOf(productId)
    if (index >= 0) {
      favs.splice(index, 1)
    } else {
      favs.push(productId)
    }
    this.saveFavorites(favs)
    return favs
  },

  isFavorite(productId) {
    return this.getFavorites().includes(productId)
  },

  // ========== WHATSAPP CHECKOUT ==========

  buildWhatsAppMessage(customer, cart) {
    const line = (text) => text + '\n'

    let msg = ''
    msg += line('🛍️ *NUEVO PEDIDO - GG STORE*')
    msg += line('')

    msg += line('👤 *Datos del Cliente:*')
    msg += line(`Nombre: ${customer.name}`)
    msg += line(`Apellido: ${customer.lastName}`)
    msg += line(`Teléfono: ${customer.phone}`)
    msg += line(`Dirección de envío: ${customer.address}`)
    msg += line('')

    msg += line('📋 *Artículos:*')
    cart.forEach((item, i) => {
      const colorName = getColorName(item.color)
      msg += line(`${i + 1}. ${item.title}`)
      msg += line(`   💰 Precio: $${parseFloat(item.price).toFixed(2)}`)
      if (colorName) msg += line(`   🎨 Color: ${colorName}`)
      if (item.size) msg += line(`   📏 Talla: ${item.size}`)
      msg += line(`   📦 Cantidad: ${item.quantity}`)
      msg += line(`   💵 Subtotal: $${(parseFloat(item.price) * item.quantity).toFixed(2)}`)
      if (item.link) msg += line(`   🔗 ${item.link}`)
      msg += line('')
    })

    const total = cart.reduce((s, i) => s + parseFloat(i.price) * i.quantity, 0)
    msg += line(`🧾 *TOTAL: $${total.toFixed(2)}*`)
    msg += line(`📱 Artículos: ${cart.reduce((s, i) => s + i.quantity, 0)}`)
    msg += line('')
    msg += line('¡Gracias por tu compra! 🙏')

    return msg
  },

  openWhatsApp(phone, message) {
    const url = `https://wa.me/${phone}?text=${encodeURIComponent(message)}`
    window.open(url, '_blank')
  },

  // ========== EVENTS ==========

  listeners: [],

  onChange(fn) {
    this.listeners.push(fn)
    return () => {
      this.listeners = this.listeners.filter(l => l !== fn)
    }
  },

  notify() {
    this.listeners.forEach(fn => fn())
  }
}

export default CartStore
