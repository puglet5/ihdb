# frozen_string_literal: true

class AddUsersToPosters < ActiveRecord::Migration[7.0]
  def change
    add_reference :posters, :user, foreign_key: true
  end
end
