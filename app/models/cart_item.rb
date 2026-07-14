class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :article
  
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  
  def subtotal
    price * quantity
  end
  
  def total_display
    "$#{subtotal.to_f}"
  end
  
  def article_with_variants
    display = article.title
    display += " (#{size})" if size.present?
    display += " - #{color}" if color.present?
    display
  end
end
