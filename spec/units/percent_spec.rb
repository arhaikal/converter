require 'rails_helper'

feature 'Percent' do
  feature 'average rate per week' do
    scenario 'returns correct result' do
      percent = Percent.new(10, "EUR", "USD", 1)

      allow(percent).to receive(:target_rates_array) {[1.1, 1.3, 1.2, 1.5, 1.4]}

      expect(percent.average_rate_per_week.length).to eq(1)
      expect(percent.average_rate_per_week).to eq([1.3])
    end
  end

  feature 'percentage increase after first week' do
    scenario 'returns NIL' do
      percent = Percent.new(10, "EUR", "USD", 1)

      allow(percent).to receive(:average_rate_per_week) {[1.1]}

      expect(percent.percentage_increase_after_first_week.length).to eq(0)
    end

    scenario 'returns correct percentage increase' do
      percent = Percent.new(10, "EUR", "USD", 3)

      allow(percent).to receive(:average_rate_per_week) {[1, 2, 4]}

      expect(percent.percentage_increase_after_first_week).to eq([100, 100])
    end
  end


  feature 'percentage change per week' do
    scenario 'returns correct data' do
      percent = Percent.new(10, "EUR", "USD", 2)

      allow(percent).to receive(:percentage_increase_after_first_week) {90}
      allow(percent).to receive(:first_percentage_increase) {33}

      expect(percent.percentage_change_per_week).to match_array([33, 90])
    end

  end
end
