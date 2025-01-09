class Rol < ApplicationRecord
 
  has_many :users
  validates :name, presence: true, uniqueness: true
  before_destroy :ensure_no_users

  private

  def ensure_no_users
    if users.exists?
      errors.add(:base, 'No se puede eliminar el rol porque está asociado a un usuario.')
      throw(:abort)  # Esto impide la eliminación
    end
  end
end
