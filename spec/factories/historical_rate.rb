FactoryGirl.define do

  factory :historical_rate do
    date Date.yesterday
  end

  factory :rate do
    EUR 1.21
    USD 1.00
    historical_rate
  end

end
