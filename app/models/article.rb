# modelo de articulos
class Article < ApplicationRecord
  paginates_per 5
  has_and_belongs_to_many :sizes
  has_many :article_colors
  belongs_to :category
  belongs_to :warehouse
  has_one_attached :attachment
  validates :title, :category, :price, presence: true
end
