class CreateExchanges < ActiveRecord::Migration[5.0]
  def change
    create_table :exchanges do |t|
      t.integer :amount
      t.string :base_currency
      t.string :target_currency
      t.integer :waiting_time

      t.timestamps
    end
  end
end
