# frozen_string_literal: true

# == Schema Information
#
# Table name: posters
#
#  id                     :bigint           not null, primary key
#  title                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint           indexed
#  plain_text_description :text
#
# Indexes
#
#  index_posters_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :poster do
    title { 'test title' }
    association :user, factory: :user, strategy: :build
  end
end
