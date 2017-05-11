class CreateHistoricalRates < ActiveRecord::Migration[5.0]
  def change
    create_table :historical_rates do |t|
      t.string :base, default: "EUR"
      t.datetime :date

      t.timestamps
    end
  end
end
