User.create(
    name:'Ivan',
    email: 'foo@bar.baz',
    password: 'foobar',
    # avatar: 'https://avatars3.githubusercontent.com/u/31633474?s=460&v=4'
)

Faker::UniqueGenerator.clear

12.times do |n|
  name = Faker::Friends.unique.character.gsub(" ", "_")
  User.create(
    name: name,
    email: "#{name}@bar.baz",
    password: 'foobar'
  )
end

# 26.times do |n|
#   name = Faker::LordOfTheRings.unique.character.gsub(" ", "_")
#   User.create(
#     name: name,
#     email: "#{name}@bar.baz",
#     password: 'foobar'
#   )
# end

# 35.times do |n|
#   name = Faker::Hobbit.unique.character.gsub(" ", "_")
#   User.create(
#     name: name,
#     email: "#{name}@bar.baz",
#     password: 'foobar'
#   )
# end

# 30.times do |n|
#   name = Faker::Simpsons.unique.character.gsub(" ", "_")
#   User.create(
#     name: name,
#     email: "#{name}@bar.baz",
#     password: 'foobar'
#   )
# end

users = User.all
users.each do |user|
  rand(0..4).times do
    description = Faker::Friends.quote
    address = Faker::Address.city
    title = Faker::Kpop.ii_groups
    datetime = Time.at(rand(10.years.ago.to_f..(Time.now + 10.years).to_f))
    user.events.create(description: description,
                       title: title,
                       address: address,
                       datetime: datetime)
  end
end

events = Event.all
events.each do |event|
  rand(1..6).times do
    event.comments.create(body: Faker::Simpsons.quote, user_id: User.all.sample.id)
  end
  puts "Начинаю подписки"
  rand(1..10).times do
    event.subscriptions.create(user_id: User.all.sample.id)
  end
  puts "Подписки закончены"
  if event.subscriptions.any?
    puts "есть подписка"
    rand(0..1).times do
      puts "начинаю грузить фотку"
      event.photos.create(remote_photo_url: Faker::LoremPixel.image, user_id: event.subscriptions.sample.user_id)
      puts "фото загружено"
    end
    puts "все фото к событию загружены"
  end
end
