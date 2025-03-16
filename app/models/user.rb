class User < ApplicationRecord
  has_many :sales
  belongs_to :rol
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { allow_blank: true }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:username]

end

def self.find_for_database_authentication(warden_conditions)
  conditions = warden_conditions.dup
  if (username = conditions.delete(:username))
    where(conditions).where(["lower(username) = :value", { value: username.downcase }]).first
  else
    where(conditions).first
  end
end

