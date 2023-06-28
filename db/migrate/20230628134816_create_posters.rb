# frozen_string_literal: true

class CreatePosters < ActiveRecord::Migration[7.0]
  def change
    create_table :posters do |t|
      t.string :title

      t.timestamps
    end
  end
end
