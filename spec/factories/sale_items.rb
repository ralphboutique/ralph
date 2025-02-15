FactoryBot.define do
  factory :sale_item do
    sale { nil }
    article { nil }
    quantity { 1 }
    price { "9.99" }
  end
end
