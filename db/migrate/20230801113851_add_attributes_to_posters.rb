# frozen_string_literal: true

class AddAttributesToPosters < ActiveRecord::Migration[7.0]
  def change
    change_table :posters, bulk: true do |t|
      t.date :acquisition_date, null: true
      t.datetime :event_datetime, null: true
      t.string :owner, null: true
      t.string :sku, null: true
      t.integer :condition, null: true
      t.integer :status, null: true
      t.integer :category, null: true
    end
  end
end
