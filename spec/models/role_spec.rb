# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  created_at    :datetime         not null
#  id            :bigint           not null, primary key
#  name          :string           indexed => [resource_type, resource_id]
#  resource_id   :bigint           indexed => [name, resource_type], indexed => [resource_type]
#  resource_type :string           indexed => [name, resource_id], indexed => [resource_id]
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_roles_on_name_and_resource_type_and_resource_id  (name,resource_type,resource_id)
#  index_roles_on_resource                                (resource_type,resource_id)
#
require 'rails_helper'

RSpec.describe Role, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
