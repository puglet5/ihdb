# frozen_string_literal: true

# == Schema Information
#
# Table name: posters
#
#  created_at             :datetime         not null
#  id                     :bigint           not null, primary key
#  plain_text_description :text
#  title                  :string
#  updated_at             :datetime         not null
#  user_id                :bigint           indexed
#
# Indexes
#
#  index_posters_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_f1941d801b  (user_id => users.id)
#
class Poster < ApplicationRecord
  include ArTransactionChanges
  include Authorship
  include ProcessImage

  belongs_to :user
  has_many :images, as: :imageable, dependent: :destroy
  has_many :image_attachments, through: :images

  accepts_nested_attributes_for :images, reject_if: proc { |attributes| attributes['image'].blank? }

  validates :title, presence: true

  has_one_attached :thumbnail do |blob|
    blob.variant :thumb, resize: '400x300^', crop: '400x300+0+0', format: :jpg
    blob.variant :banner, resize: '1600x900^', crop: '1600x900+0+0', format: :jpg
  end

  has_rich_text :description

  before_save { self.plain_text_description = description&.body&.to_plain_text }
  after_commit -> { process_image self, thumbnail&.id }, on: %i[create update], unless: -> { transaction_changed_attributes.keys == ['updated_at'] }
end
