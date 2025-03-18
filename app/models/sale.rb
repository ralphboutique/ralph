class Sale < ApplicationRecord
  belongs_to :user
  has_many :sale_items, dependent: :restrict_with_error
  has_many :sales, through: :sale_items
  has_many :articles, through: :sale_items
  has_many :sale_items, dependent: :destroy
  accepts_nested_attributes_for :sale_items
  validates :name, :lastname, :id_number, :phone,:payment_method, presence: true
  validates :payment_method, presence: true, inclusion: { in: ['usd', 'bs'] }
  validates :date, presence: true
  before_create :set_default_paid_installments

  private
  def set_default_paid_installments
    self.paid_installments ||= 0
  end
  
  accepts_nested_attributes_for :sale_items, allow_destroy: true
end
