# frozen_string_literal: true

# == Schema Information
#
# Table name: posters
#
#  acquisition_date                 :date
#  category                         :integer
#  collection                       :integer          not null
#  concert                          :string
#  condition                        :integer
#  created_at                       :datetime         not null
#  dimensions                       :jsonb
#  event_datetime                   :datetime
#  fiber_type                       :integer          not null
#  id                               :bigint           not null, primary key
#  locality_id                      :bigint           indexed
#  owner                            :string
#  performer                        :string
#  ph_data                          :jsonb
#  plain_text_condition_description :text
#  plain_text_description           :text
#  plain_text_fiber_description     :text
#  plain_text_notes                 :text
#  sku                              :string
#  status                           :integer
#  title                            :string
#  updated_at                       :datetime         not null
#  user_id                          :bigint           indexed
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
