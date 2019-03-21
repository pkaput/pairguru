FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(8) }
    confirmed_at Time.now
    name { Faker::Name.name }
  end
end
