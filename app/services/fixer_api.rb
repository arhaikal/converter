require 'httparty'
class FixerApi
  include HTTParty

  def self.make_api_call(date)
    get("http://api.fixer.io/" + date.to_s)
  end

  def self.add_api_to_db(date)
    api = FixerApi.make_api_call(date)

    historical_rate = HistoricalRate.new(date: date)
    historical_rate.save

    rate= Rate.new(historical_rate_id: historical_rate.id,
                                 AUD: api["rates"]["AUD"],
                                 CAD: api["rates"]["CAD"],
                                 CHF: api["rates"]["CHF"],
                                 CZK: api["rates"]["CZK"],
                                 DKK: api["rates"]["DKK"],
                                 GBP: api["rates"]["GBP"],
                                 HKD: api["rates"]["HKD"],
                                 HUF: api["rates"]["HUF"],
                                 JPY: api["rates"]["JPY"],
                                 KRW: api["rates"]["KRW"],
                                 NOK: api["rates"]["NOK"],
                                 NZD: api["rates"]["NZD"],
                                 PLN: api["rates"]["PLN"],
                                 SEK: api["rates"]["SEK"],
                                 SGD: api["rates"]["SGD"],
                                 USD: api["rates"]["USD"],
                                 ZAR: api["rates"]["ZAR"])
    rate.save
  end
end
