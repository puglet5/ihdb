# frozen_string_literal: true

class AddMoreAttributesToPosters < ActiveRecord::Migration[7.1]
  def change
    change_table :posters, bulk: true do |t|
      t.integer :collection, null: false
      t.integer :fiber_type, null: false
      t.string :concert, null: true
      t.string :performer, null: true
      t.jsonb :ph_data, null: true
      t.jsonb :dimensions, null: true
    end
  end
end
