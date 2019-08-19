FactoryBot.define do
  factory :message do
    user
    conversation
    body { Faker::Movies::StarWars.wookiee_sentence }
    read { false }
  end
end
