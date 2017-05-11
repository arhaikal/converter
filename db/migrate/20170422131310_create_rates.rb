class CreateRates < ActiveRecord::Migration[5.0]
  def change
    create_table :rates do |t|
      t.belongs_to :historical_rate, index: true
      t.decimal :EUR, default: 1
      t.decimal :AUD, precision: 8, scale: 3
      t.decimal :CAD, precision: 8, scale: 3
      t.decimal :CHF, precision: 8, scale: 3
      t.decimal :CZK, precision: 8, scale: 3
      t.decimal :DKK, precision: 8, scale: 3
      t.decimal :GBP, precision: 8, scale: 3
      t.decimal :HKD, precision: 8, scale: 3
      t.decimal :HUF, precision: 8, scale: 3
      t.decimal :JPY, precision: 8, scale: 3
      t.decimal :KRW, precision: 8, scale: 3
      t.decimal :NOK, precision: 8, scale: 3
      t.decimal :NZD, precision: 8, scale: 3
      t.decimal :PLN, precision: 8, scale: 3
      t.decimal :SEK, precision: 8, scale: 3
      t.decimal :SGD, precision: 8, scale: 3
      t.decimal :USD, precision: 8, scale: 3
      t.decimal :ZAR, precision: 8, scale: 3

      t.timestamps
    end
  end
end
