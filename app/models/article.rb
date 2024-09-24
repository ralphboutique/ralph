# modelo de articulos
class Article < ApplicationRecord
  paginates_per 5
  belongs_to :category
  belongs_to :size
  belongs_to :color
  belongs_to :werehouse
  has_one_attached :attachment
  # has_one_attached :image
  validates :title, :category, :price, presence: true
end
