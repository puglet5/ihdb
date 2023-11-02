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
RSpec.describe Image, type: :model do
  describe 'associations' do
    it { should belong_to(:imageable) }
  end
end
