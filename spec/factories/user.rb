FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(8) }
    confirmed_at Time.now
    name { Faker::Name.name }

    trait :with_random_number_of_comments do
      after(:create) do |user|
        create_list :comment, rand(10) + 1, movie: create(:movie), user: user
      end
    end
  end
end
