FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    last_name { Faker::Games::ElderScrolls.last_name }
    first_name { Faker::Games::ElderScrolls.first_name }
    password { Faker::Alphanumeric.alphanumeric(number: 10) }
    born_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
