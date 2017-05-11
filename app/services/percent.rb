class Percent
  def initialize(amount, base, target, time)
    @amount = amount
    @base = base
    @target = target
    @time = time
  end

  def percentage_change_per_week
    percentage_array = []
    percentage_array << first_percentage_increase
    percentage_array << percentage_increase_after_first_week if @time > 1
    percentage_array
  end

  def average_rate_per_week
    averages_array = []
    a = target_rates_array
    a.each_slice(5) do |week|
      week_total = 0
      week.each do |day|
        week_total += day
      end
      averages_array << week_total / 5
    end
    averages_array
  end

  def percentage_increase_after_first_week
    average_week = average_rate_per_week
    percentage_array = []
    i = 1
    while i < average_week.length
      percentage_increase = ((average_week[i] - average_week[i - 1]) /
                            average_week[i - 1]) * 100
      percentage_array << percentage_increase
      i += 1
    end
    percentage_array
  end

  private

  def target_rates_array
    GetRate.new(@base, @target, @time).rates_in_db
  end

  def first_percentage_increase
    average_week = average_rate_per_week
    targets_array = target_rates_array
    ((average_week[0] - targets_array[0]) / targets_array[0]) * 100
  end
end
