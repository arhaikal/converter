require 'rails_helper'

feature 'Get Rate' do
  feature 'all_dates' do
    scenario 'gets all dates needed for db' do
      get_rate = GetRate.new("EUR", "USD", 2)

      allow(get_rate).to receive(:start_date) { Date.today - 13.days}
      allow(get_rate).to receive(:latest_date) { Date.today }

      expect(get_rate.all_dates.length).to eq(10)
    end
  end

  feature 'getting dates from db' do
    scenario 'recieving correct ids from historical rate' do
      get_rate = GetRate.new("EUR", "USD", 1)
      HistoricalRate.create([{id: 5, date: "Wed, 10 May 2017"},
                            {id: 4, date: "Tue, 09 May 2017"},
                            {id: 3, date: "Mon, 08 May 2017"},
                            {id: 2, date: "Fri, 05 May 2017"},
                            {id: 1, date: "Thu, 04 May 2017"} ])

      allow(get_rate).to receive(:all_dates) { ["Wed, 10 May 2017",
                                            "Tue, 09 May 2017",
                                            "Mon, 08 May 2017",
                                            "Fri, 05 May 2017",
                                            "Thu, 04 May 2017" ]}

      expect(get_rate.dates_in_db).to match_array([5, 4, 3, 2, 1])
    end
  end

  feature 'getting rates from db' do
    scenario 'recieving correct amount of rates' do
      get_rate = GetRate.new("EUR", "USD", 1)
      rate = Rate.create([ {historical_rate_id: 5, EUR: 1.11, USD: 0.91},
                    {historical_rate_id: 4, EUR: 1.12, USD: 0.98},
                    {historical_rate_id: 3, EUR: 1.13, USD: 0.92},
                    {historical_rate_id: 2, EUR: 1.14, USD: 0.94},
                    {historical_rate_id: 1, EUR: 1.15, USD: 0.93}])
    #   HistoricalRate.create([{id: 5, date: "Wed, 10 May 2017"},
    #                         {id: 4, date: "Tue, 09 May 2017"},
    #                         {id: 3, date: "Mon, 08 May 2017"},
    #                         {id: 2, date: "Fri, 05 May 2017"},
    #                         {id: 1, date: "Thu, 04 May 2017"} ])
     #
    #  allow(get_rate).to receive(:all_dates) { ["Wed, 10 May 2017",
    #                                         "Tue, 09 May 2017",
    #                                         "Mon, 08 May 2017",
    #                                         "Fri, 05 May 2017",
    #                                         "Thu, 04 May 2017" ]}
      # expect(get_rate.rates_in_db.length).to eq(5)
    end
  end
end
