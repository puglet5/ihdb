# frozen_string_literal: true

# == Schema Information
#
# Table name: images
#
#  category          :integer
#  created_at        :datetime         not null
#  id                :bigint           not null, primary key
#  imageable_id      :bigint           not null, indexed => [imageable_type]
#  imageable_type    :string           not null, indexed => [imageable_id]
#  restoration_state :integer
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_images_on_imageable  (imageable_type,imageable_id)
#
class Image < ApplicationRecord
  include ProcessImage
  include ArTransactionChanges

  belongs_to :imageable, polymorphic: true, inverse_of: :images, touch: true

  has_one_attached :image do |blob|
    blob.variant :thumb, resize: '400x300^', crop: '400x300+0+0', format: :jpg
  end

  enum category: { misc: 0, fiber: 1 }, _default: :misc
  enum restoration_state: { pre: 0, post: 1, other: 3 }, _default: :other

  validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif'] }

  after_commit -> { process_image self, image&.id }, on: %i[create update], unless: -> { transaction_changed_attributes.keys == ['updated_at'] }
end
