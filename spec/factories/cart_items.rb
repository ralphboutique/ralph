FactoryBot.define do
  factory :cart_item do
    cart { nil }
    article { nil }
    quantity { 1 }
    price { "9.99" }
  end
end
