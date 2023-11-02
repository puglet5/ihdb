# frozen_string_literal: true

class AddCategoryToImages < ActiveRecord::Migration[7.1]
  def change
    add_column :images, :category, :integer
  end
end
