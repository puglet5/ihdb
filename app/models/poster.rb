# frozen_string_literal: true

# == Schema Information
# Schema version: 20230628134816
#
# Table name: posters
#
#  created_at :datetime         not null
#  id         :bigint           not null, primary key
#  title      :string
#  updated_at :datetime         not null
#
class Poster < ApplicationRecord
  has_many :images, as: :imageable, dependent: :destroy

  validates :title, presence: true
end
