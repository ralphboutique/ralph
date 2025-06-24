class Color < ApplicationRecord
  has_many :articles_colors
  has_many :articles, through: :articles_colors
end
