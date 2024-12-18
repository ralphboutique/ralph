class Category < ApplicationRecord
  has_many :articles
  validates :title, presence: true, uniqueness: true
  before_destroy :ensure_no_articles


  private

  def ensure_no_articles
    if articles.exists?
      errors.add(:base, 'No se puede eliminar la categoría porque está asociada a productos.')
      throw(:abort)  # Esto impide la eliminación
    end
  end
end
