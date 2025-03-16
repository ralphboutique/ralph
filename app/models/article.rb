# modelo de articulos
class Article < ApplicationRecord
  paginates_per 5
  has_and_belongs_to_many :sizes
  has_many :article_colors
  belongs_to :category
  belongs_to :warehouse
  has_one_attached :attachment
  validates :title, :category, :price, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  has_many :sales
  has_many :sale_items, dependent: :restrict_with_error
  has_many :sales, through: :sale_items

  before_destroy :check_sales

  private

  def check_sales
    if sale_items.exists?
      errors.add(:base, "No se puede eliminar porque tiene ventas asociadas.")
      throw(:abort)
    end
  end
end
