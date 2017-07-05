class GetRate
  API_UPDATE_TIME = Time.parse("6:30 pm")

  def initialize(base, target, weeks)
    @base = base
    @target = target
    @weeks = weeks
  end

  def dates_in_db
    HistoricalRate.where(date: working_dates).pluck(:id)
  end

  def rates_in_db
    Rate.where(historical_rate_id: dates_in_db)
      .pluck(@base.to_s, @target.to_s)
      .map { |base_rate, target_rate| target_rate / base_rate }
  end

  def working_dates
    # What about national holidays?
    (start_date..latest_date).select(&:on_weekday?)
  end

  private

  def latest_date
    # This condition is because the api updates at that weeks
    Time.now < API_UPDATE_TIME ? Date.yesterday : Date.today
  end

  def start_date
    # The total should be 5 days not 6 days so we don't have overlap
    latest_date - (@weeks.weeks - 1.day)
  end
end
