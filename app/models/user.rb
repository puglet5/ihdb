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
class User < ApplicationRecord
  include ProcessImage
  include ArTransactionChanges

  has_person_name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posters, dependent: :destroy

  has_one_attached :avatar do |blob|
    blob.variant :small, resize: '50x50^', crop: '50x50+0+0', format: :jpg
    blob.variant :medium, resize: '100x100^', crop: '100x100+0+0', format: :jpg
    blob.variant :thumb, resize: '400x400^', crop: '400x400+0+0', format: :jpg
  end

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  validates :name, presence: true
  validates :password, confirmation: true
  validates :avatar, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'] }

  after_commit -> { process_image self, avatar&.id }, on: %i[create update], unless: -> { transaction_changed_attributes.keys == ['updated_at'] }

  def guest?
    false
  end

  def author?(obj)
    obj.user == self
  end

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end
end
