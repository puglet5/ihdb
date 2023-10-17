# frozen_string_literal: true

# == Schema Information
#
# Table name: posters
#
#  acquisition_date       :date
#  category               :integer
#  condition              :integer
#  created_at             :datetime         not null
#  event_datetime         :datetime
#  id                     :bigint           not null, primary key
#  locality_id            :bigint           indexed
#  owner                  :string
#  plain_text_description :text
#  sku                    :string
#  status                 :integer
#  title                  :string
#  updated_at             :datetime         not null
#  user_id                :bigint           indexed
#
# Indexes
#
#  index_posters_on_locality_id  (locality_id)
#  index_posters_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_159072e4b0  (locality_id => localities.id)
#  fk_rails_f1941d801b  (user_id => users.id)
#
class Poster < ApplicationRecord
  include ArTransactionChanges
  include Authorship
  include ProcessImage

  resourcify

  belongs_to :user
  belongs_to :locality, optional: true
  has_many :images, as: :imageable, dependent: :destroy
  has_many :image_attachments, through: :images

  accepts_nested_attributes_for :images, reject_if: proc { |attributes| attributes['image'].blank? }

  validates :title, presence: true

  enum status: { displayed: 0, archived: 1 }, _default: :archived
  enum condition: { perfect: 0, damaged: 1 }, _default: :damaged
  enum category: { poster: 0 }, _default: :poster

  has_one_attached :thumbnail do |blob|
    blob.variant :thumb, resize: '400x300^', crop: '400x300+0+0', format: :jpg
    blob.variant :banner, resize: '1600x900^', crop: '1600x900+0+0', format: :jpg
  end

  has_rich_text :description

  before_save { self.plain_text_description = description&.body&.to_plain_text }
  after_commit -> { process_image self, thumbnail&.id }, on: %i[create update], unless: -> { transaction_changed_attributes.keys == ['updated_at'] }
end
