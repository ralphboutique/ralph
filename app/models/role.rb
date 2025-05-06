class Role < ApplicationRecord
   
  has_many :users
  validates :name, presence: true, uniqueness: true
  before_destroy :check_associations
  has_many :role_permissions
  has_many :permissions, through: :role_permissions
  has_many :areas, through: :role_permissions
  private

  private

  def check_associations
    if users.exists? || role_permissions.exists?
      errors.add(:base, 'No se puede eliminar el rol porque tiene usuarios o permisos asignados.')
      throw :abort
    end
  end
end
