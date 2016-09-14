#User

User.create! fullname: "User",
             email: "user@gmail.com",
             password: "password",
             password_confirmation: "password"

User.create! fullname: "Admin User",
             email: "admin@gmail.com",
             password: "password",
             password_confirmation: "password",
             is_admin: true

49.times do |n|
  name  = Faker::Name.name
  email = "Test-#{n+1}@gmail.com"
  password = "password"
  User.create! fullname:  name,
               email: email,
               password: password,
               password_confirmation: password
end

# Following relationships
users = User.all
user  = users.first
following = users[2..20]
followers = users[3..10]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}


# Categories
40.times do
  name  = Faker::Name.name
  description = Faker::Lorem.sentence
  Category.create! name: name, description: description
end

# Words
categories = Category.order(:created_at).take 20

30.times do
  content = Faker::Lorem.word
  categories.each do |category|
    right_answer = rand(0..Settings.answers_num_default-1)
    word = Word.new content: content, category: category
    Settings.answers_num_default.times do |i|
      answer = Answer.new content: content, is_true: i == right_answer
      word.answers << answer
    end
    word.save
  end
end

# Lessons
categories.each do |category|
  lesson = Lesson.new user: User.first, category: category
  lesson.save
  words = category.words.take 10
  words.each do |word|
    result = Result.new word: word, lesson: lesson, answer: word.answers.first
    result.save
  end
end

