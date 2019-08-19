FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    last_name { Faker::Games::ElderScrolls.unique.last_name }
    first_name { Faker::Games::ElderScrolls.unique.first_name }
    password { 'password' }
    born_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
