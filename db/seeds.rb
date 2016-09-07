# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Categories
100.times do |n|
  name  = Faker::Name.name
  description = Faker::Lorem.sentence

  Category.create!(name:  name, description: description)
end

# Words
categories = Category.order(:created_at).take(10)

10.times do
  content = Faker::Lorem.word
  categories.each do |category|
    category.words.create!(content: content)
  end
end
