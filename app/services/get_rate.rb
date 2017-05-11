class GetRate
  def initialize(base, target, time)
    @base = base
    @target = target
    @time = time
  end

  def dates_in_db
    historical_id = HistoricalRate.where(date: all_dates)
                                  .select(:id)
    historical_id.ids
  end

  def rates_in_db
    rates_in_db = Rate.where(historical_rate_id: dates_in_db)
                      .select(@base.to_s, @target.to_s)
                      .map { |rate| rate[@target] / rate[@base] }
    rates_in_db
  end


  def all_dates
    (start_date..latest_date).select { |d| (1..5).cover?(d.wday) }
  end

  private

  def latest_date
    api_update_time = Time.parse("6:30 pm")
    # This condition is because the api updates at that time
    if Time.now < api_update_time
      Date.yesterday
    else
      Date.today
    end
  end

  def start_date
    # The total should be 5 days not 6 days so we don't have overlap
    latest_date - ((@time * 7) - 1).day
  end
end
