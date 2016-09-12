#User
User.create!(fullname: "Admin User",
             email: "admin@gmail.com",
             password: "password",
             password_confirmation: "password",
             is_admin: true)
49.times do |n|
  name  = Faker::Name.name
  email = "Test-#{n+1}@gmail.com"
  password = "password"
  User.create!(fullname:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

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
    right_answer = rand(0..Settings.answers_num_default-1)
    word = Word.new(content: content, category: category)
    Settings.answers_num_default.times do |i|
      answer = Answer.new(content: content, is_true: i == right_answer)
      word.answers << answer
    end
    word.save
  end
end
