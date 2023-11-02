# frozen_string_literal: true

class AddRestorationStateEnumToImages < ActiveRecord::Migration[7.1]
  def change
    add_column :images, :restoration_state, :integer
  end
end
