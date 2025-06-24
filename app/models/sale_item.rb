class SaleItem < ApplicationRecord
  belongs_to :sale
  belongs_to :article
  validates :quantity, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }
  after_create :decrease_article_stock
  
  private

  def decrease_article_stock
    if article.quantity >= quantity
      article.decrement!(:quantity, quantity)
    else
      errors.add(:quantity, "No hay suficiente stock disponible para #{article.title}.")
      raise ActiveRecord::Rollback 
    end
  end
end
