require 'rails_helper'

feature 'Prediction' do
  feature 'final_prediction' do
    scenario 'returns correct result' do
      prediction = Prediction.new(10, "EUR", "USD", 1)

      allow(prediction).to receive(:rates_prediction) {
                                                        [1,
                                                         1.2,
                                                         1.3,
                                                         1.22,
                                                         1.11]
                                                      }
      allow(prediction).to receive(:week_year_array) {
                                                       ["2017-05-23",
                                                        "2017-05-24",
                                                        "2017-05-25",
                                                        "2017-05-26",
                                                        "2017-05-27"]
                                                     }

      expect(prediction.final_prediction).to include({ rate: 1,
                                                       date: "2017-05-23",
                                                       amount: 10 })
      expect(prediction.final_prediction.length).to eq(5)
    end
  end
end
