class AddUserToTest < ActiveRecord::Migration[6.0]
  def change
    add_reference :tests, :user, null: false, foreign_key: true
  end
end