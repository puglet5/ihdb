# frozen_string_literal: true

class AddPlainTextDescriptionToPosters < ActiveRecord::Migration[7.0]
  def change
    add_column :posters, :plain_text_description, :text
  end
end
