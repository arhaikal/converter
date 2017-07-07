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
    GetRate.new(@base, @target, @time).rates_in_db.last

  end

  def weekly_percentage_change_array
    Percent.new(@amount, @base, @target, @time).percentage_change_per_week
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
    @time.times.map { |i| Date.today + (i + 1).weeks }
  end
end
