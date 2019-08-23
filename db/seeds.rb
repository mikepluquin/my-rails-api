# ------------ users ---------------

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
(1..50).to_a.each do |n|
  users << {
    email: Faker::Internet.unique.email,
    last_name: Faker::Games::ElderScrolls.last_name,
    first_name: Faker::Games::ElderScrolls.first_name,
    password: Faker::Alphanumeric.alphanumeric(number: 10),
    born_date: Faker::Date.birthday(min_age: 18, max_age: 65)
  }
end

User.create(users)

# ------------ posts ---------------

posts = []

(1..500).to_a.each do |n|
  posts << {
    body: Faker::Movies::StarWars.quote,
    user: User.order("RANDOM()").first
  }
end

Post.create(posts)


# ------------ likes ---------------

likes = []

(1..1000).to_a.each do |n|
  likes << {
    post: Post.order("RANDOM()").first,
    user: User.order("RANDOM()").first
  }
end

Like.create(likes)

# ------------ followings ---------------

followings = []

(1..200).to_a.each do |n|
  followings << {
    followed: User.order("RANDOM()").first,
    follower: User.order("RANDOM()").first
  }
end

Following.create(followings)

# ------------ conversations ---------------

conversations = []

(1..200).to_a.each do |n|
  conversations << {
    sender: User.order("RANDOM()").first,
    recipient: User.order("RANDOM()").first
  }
end

Conversation.create(conversations)

# ------------ messages ---------------

messages = []

(1..1000).to_a.each do |n|
  conversation = Conversation.order("RANDOM()").first
  messages << {
    user: [conversation.sender, conversation.recipient].sample,
    conversation: conversation,
    body: Faker::Movies::StarWars.wookiee_sentence,
    read: true
  }
end

Message.create(messages)
