# frozen_string_literal: true

# == Schema Information
#
# Table name: localities
#
#  created_at :datetime         not null
#  id         :bigint           not null, primary key
#  lat        :decimal(10, 7)
#  lng        :decimal(10, 7)
#  name       :string           not null
#  updated_at :datetime         not null
#
class Locality < ApplicationRecord
  validates :name, presence: true
  has_many :posters, dependent: :nullify
end
