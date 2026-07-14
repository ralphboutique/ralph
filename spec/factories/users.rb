FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
    status { "active" }
    
    # Asociación con role
    association :role

    trait :admin do
      username { "admin" }
      email { "admin@ralph.com" }
      after(:create) do |user|
        admin_role = create(:admin_role)
        user.update(role: admin_role)
      end
    end

    trait :inactive do
      status { "inactive" }
    end

    trait :with_warehouses do
      after(:create) do |user|
        warehouses = create_list(:warehouse, 2)
        user.warehouses = warehouses
      end
    end

    factory :admin_user, traits: [:admin]
    factory :inactive_user, traits: [:inactive]
    factory :user_with_warehouses, traits: [:with_warehouses]
  end
end
