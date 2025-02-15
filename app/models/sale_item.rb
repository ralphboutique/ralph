class SaleItem < ApplicationRecord
  belongs_to :sale
  belongs_to :article

  validates :quantity, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }

  after_create :decrease_article_stock

  private

  def decrease_article_stock
    article.decrement!(:quantity, quantity) if article.quantity >= quantity
  end
end
