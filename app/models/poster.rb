# frozen_string_literal: true

# == Schema Information
#
# Table name: posters
#
#  created_at :datetime         not null
#  id         :bigint           not null, primary key
#  title      :string
#  updated_at :datetime         not null
#
class Poster < ApplicationRecord
  belongs_to :user
  has_many :images, as: :imageable, inverse_of: :poster, dependent: :destroy

  validates :title, presence: true
end
