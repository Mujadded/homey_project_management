FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "password123" }
    role { :member }

    trait :admin do
      role { :admin }
    end

    trait :pm do
      role { :pm }
    end
  end
end
