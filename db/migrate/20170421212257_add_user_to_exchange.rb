class AddUserToExchange < ActiveRecord::Migration[5.0]
  def change
    add_reference :exchanges, :user, foreign_key: true
  end
end
