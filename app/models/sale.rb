class Sale < ApplicationRecord
  belongs_to :user
  has_many :sale_items, dependent: :destroy
  accepts_nested_attributes_for :sale_items
  validates :payment_method, presence: true, inclusion: { in: ['usd', 'bs'] }
  validates :date, presence: true

  private

  accepts_nested_attributes_for :sale_items, allow_destroy: true
end
