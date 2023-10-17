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
FactoryBot.define do
  factory :poster do
    title { 'test title' }
    association :user, factory: :user, strategy: :build
  end
end
