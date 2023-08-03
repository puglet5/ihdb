# frozen_string_literal: true

require 'faker'

10.times do
  Locality.create!(
    name: Faker::Address.city
  )
end

10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: '123456',
    password_confirmation: '123456'
  )
end

10.times do
  p = Poster.new(
    title: Faker::Book.title,
    user: User.all.sample,
    locality: Locality.all.sample,
    owner: Faker::Name.name,
    acquisition_date: Faker::Date.in_date_period,
    event_datetime: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    category: 0,
    status: 0,
    condition: 0,
    sku: Faker::Barcode.ean
  )
  i = Image.new(imageable: p)
  i.image.attach(io: File.open('spec/fixtures/files/test.jpeg'), filename: 'image.jpeg', content_type: 'image/jpeg')
  i.save!
  p.save!
end
