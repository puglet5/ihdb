# frozen_string_literal: true

# == Schema Information
#
# Table name: images
#
#  id             :bigint           not null, primary key
#  imageable_type :string           not null, indexed => [imageable_id]
#  imageable_id   :bigint           not null, indexed => [imageable_type]
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_images_on_imageable  (imageable_type,imageable_id)
#
RSpec.describe Image, type: :model do
  describe 'associations' do
    it { should belong_to(:imageable) }
  end
end
