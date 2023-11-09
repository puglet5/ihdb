# frozen_string_literal: true

class AddPlainTextAttributesToPosters < ActiveRecord::Migration[7.1]
  def change
    change_table :posters, bulk: true do |t|
      t.text :plain_text_condition_description
      t.text :plain_text_fiber_description
      t.text :plain_text_notes
    end
  end
end
