# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  created_at             :datetime         not null
#  email                  :string           default(""), not null, indexed
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default(""), not null
#  id                     :bigint           not null, primary key
#  last_name              :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string           indexed
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    password         { '123456' }
    first_name       { 'Test' }
    last_name        { 'Test' }
    sequence(:email) { |n| "test#{n}@test.com" }
  end
end
