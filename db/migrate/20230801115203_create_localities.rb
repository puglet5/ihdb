# frozen_string_literal: true

class CreateLocalities < ActiveRecord::Migration[7.0]
  def change
    create_table :localities do |t|
      t.decimal :lat,  precision: 10, scale: 7, null: true
      t.decimal :lng,  precision: 10, scale: 7, null: true
      t.string  :name, null: false
      t.timestamps
    end
  end
end
