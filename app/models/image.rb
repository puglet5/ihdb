# frozen_string_literal: true

# == Schema Information
# Schema version: 20230628134816
#
# Table name: images
#
#  created_at     :datetime         not null
#  id             :bigint           not null, primary key
#  imageable_id   :bigint           not null, indexed => [imageable_type]
#  imageable_type :string           not null, indexed => [imageable_id]
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_images_on_imageable  (imageable_type,imageable_id)
#
class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  has_one_attached :image do |blob|
    blob.variant :thumb, resize: '400x300^', crop: '400x300+0+0', format: :jpg
  end
end
