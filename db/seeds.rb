users = []

# custom user
users << {
  email: 'mike.pluquin@gmail.com',
  last_name: 'Pluquin',
  first_name: 'Mike',
  password: 'password',
  born_date:  DateTime.new(1995, 8, 6)
}

# n random users
(1..20).to_a.each do |n|
  users << {
    email: Faker::Internet.unique.email,
    last_name: Faker::Games::ElderScrolls.last_name,
    first_name: Faker::Games::ElderScrolls.first_name,
    password: Faker::Internet.unique.password,
    born_date: Faker::Date.birthday(min_age: 18, max_age: 65)
  }
end

User.create!(users)
