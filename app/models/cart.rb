class Cart < ApplicationRecord
  belongs_to :user, optional: true # Permitir carritos de invitados
  has_many :cart_items, dependent: :destroy
  has_many :articles, through: :cart_items
  
  validates :session_id, presence: true
  validates :status, inclusion: { in: %w[active completed abandoned] }
  
  scope :active, -> { where(status: 'active') }
  scope :for_user, ->(user) { where(user: user) }
  scope :for_session, ->(session_id) { where(session_id: session_id) }
  
  def total_items
    cart_items.sum(:quantity)
  end
  
  def empty?
    cart_items.empty?
  end
  
  def add_article(article, quantity: 1, size: nil, color: nil)
    ActiveRecord::Base.transaction do
      existing_item = cart_items.find_by(article: article, size: size, color: color)
      
      if existing_item
        new_quantity = existing_item.quantity + quantity
        existing_item.update!(quantity: new_quantity)
      else
        cart_items.create!(
          article: article,
          quantity: quantity,
          price: article.price,
          size: size,
          color: color
        )
      end
      
      # Recargar para obtener los items actualizados
      reload
      calculate_total
      save!
    end
  end
  
  def remove_article(article, size: nil, color: nil)
    ActiveRecord::Base.transaction do
      cart_items.find_by(article: article, size: size, color: color)&.destroy
      reload # Reload para refrescar los cart_items
      calculate_total
      save!
    end
  end
  
  def update_quantity(cart_item_id, quantity)
    ActiveRecord::Base.transaction do
      item = cart_items.find(cart_item_id)
      if quantity > 0
        item.update!(quantity: quantity)
      else
        item.destroy
      end
      reload # Reload para refrescar los cart_items
      calculate_total
      save!
    end
  end
  
  def clear!
    cart_items.destroy_all
    update!(total: 0.0)
  end
  
  # Para generar el mensaje de WhatsApp
  def whatsapp_message
    message = "🛒 *NUEVO PEDIDO - RALPH BOUTIQUE*\n\n"
    message += "📋 *Detalles del pedido:*\n"
    
    cart_items.each_with_index do |item, index|
      message += "#{index + 1}. #{item.article.title}\n"
      message += "   💰 Precio: $#{item.price}\n"
      message += "   📦 Cantidad: #{item.quantity}\n"
      message += "   📏 Talla: #{item.size || 'No especificada'}\n" if item.size
      message += "   🎨 Color: #{item.color || 'No especificado'}\n" if item.color
      message += "   💵 Subtotal: $#{item.price * item.quantity}\n\n"
    end
    
    message += "🧾 *TOTAL: $#{total}*\n"
    message += "📱 Total de artículos: #{total_items}\n\n"
    message += "¡Gracias por tu compra! 🙏"
    
    message
  end
  
  def calculate_total
    self.total = cart_items.sum { |item| item.price * item.quantity }
  end
  
  private
end
