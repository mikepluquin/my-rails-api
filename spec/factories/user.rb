FactoryBot.define do
  factory :user do
    email {Faker::Internet.unique.email}
    last_name {Faker::Games::ElderScrolls.unique.last_name}
    first_name {Faker::Games::ElderScrolls.unique.first_name}
    password {Faker::Internet.unique.password}
  end
end
