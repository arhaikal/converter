class Prediction
  def initialize(amount, base, target, time)
    @amount = amount
    @base = base
    @target = target
    @time = time
  end

  def final_prediction
    rates_prediction.zip(week_year_array).map do |rate, date|
      { "rate": rate, "date": date, "amount": (rate * @amount) }
    end
  end

  private

  def today_rate
    rate = GetRate.new(@base, @target, @time).rates_in_db
    rate.last
  end

  def percentage_wraper
    Percent.new(@amount, @base, @target, @time)
  end

  def weekly_percentage_change_array
    percentage_wraper.percentage_change_per_week
  end

  # ((percent/100) * number) + number
  def rates_prediction
    final_array = []
    today = today_rate
    weekly_change = weekly_percentage_change_array

    first = ((weekly_change[0] / 100) * today) + today
    final_array << first

    if @time > 1
      i = 0
      while i < weekly_change[1].length
        rate = ((weekly_change[1][i] / 100) * final_array[i]) + final_array[i]
        final_array << rate
        i += 1
      end
    end
    final_array
  end

  def week_year_array
    dates_array = []
    while @time > 0
      date = date_of_next(@time)
      dates_array.unshift(date)
      @time -= 1
    end
    dates_array
  end

  def date_of_next(weeks)
    date  = Date.parse(Time.now.to_datetime.strftime("%A"))
    delta = date > Date.today ? 0 : (7 * weeks)
    date + delta
  end

end
