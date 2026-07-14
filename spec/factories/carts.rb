FactoryBot.define do
  factory :cart do
    user { nil }
    session_id { "MyString" }
    total { "9.99" }
    status { "MyString" }
  end
end
