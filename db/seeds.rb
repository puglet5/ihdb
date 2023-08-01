# frozen_string_literal: true

require 'faker'

10.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: '123456', password_confirmation: '123456')
end

10.times do
  p = Poster.new(title: Faker::Book.title, user: User.all.sample)
  i = Image.new(imageable: p)
  i.image.attach(io: File.open('spec/fixtures/files/test.jpeg'), filename: 'image.jpeg', content_type: 'image/jpeg')
  i.save!
  p.save!
end
