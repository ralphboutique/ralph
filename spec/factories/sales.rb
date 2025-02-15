FactoryBot.define do
  factory :sale do
    user { nil }
    payment_method { "MyString" }
    date { "2025-02-13" }
    total_amount { "9.99" }
  end
end
