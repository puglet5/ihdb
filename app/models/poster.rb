# frozen_string_literal: true

# == Schema Information
#
# Table name: posters
#
#  created_at :datetime         not null
#  id         :bigint           not null, primary key
#  title      :string
#  updated_at :datetime         not null
#  user_id    :bigint           indexed
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
  belongs_to :user
  has_many :images, as: :imageable, dependent: :destroy

  validates :title, presence: true
end
