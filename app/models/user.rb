class User < ApplicationRecord
  has_and_belongs_to_many :warehouses  
  has_many :sales
  belongs_to :role

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { allow_blank: true }
  validates :status, presence: true, inclusion: { in: %w[active inactive] }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:username]

  def active_for_authentication?
    super && status == "active"
  end
  def inactive_message
    status == "active" ? super : :not_active
  end
end
