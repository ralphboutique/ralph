class Warehouse < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :articles
  validates :title, presence: true, uniqueness: true
  before_destroy :ensure_no_articles


  private

  def ensure_no_articles
    if articles.exists?
      errors.add(:base, 'No se puede eliminar el almacen porque está asociada a productos.')
      throw(:abort)  # Esto impide la eliminación
    end
  end
end
