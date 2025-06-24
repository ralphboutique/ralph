class ArticleColor < ApplicationRecord
  self.table_name = 'articles_colors'  
  belongs_to :article
  validates :color_hex, presence: true
end
