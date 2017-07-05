class Percent
  def initialize(amount, base, target, weeks)
    @amount = amount
    @base = base
    @target = target
    @weeks = weeks
  end

  def percentage_change_per_week
    percentage_array = []
    percentage_array << first_percentage_increase
    percentage_array << percentage_increase_after_first_week if @weeks > 1
    percentage_array
  end

  def percentage_increase_after_first_week
    average_week = average_rate_per_week
    average_week.map.with_index do |rate, index|
      next if index.zero?
      ((average_week[index] - average_week[index - 1]) / average_week[index - 1]) * 100
    end.compact
  end

  def average_rate_per_week
    @average_rate_per_week ||= target_rates_array.each_slice(5).map { |week| week.sum / 5 }
  end

  private

  def target_rates_array
    GetRate.new(@base, @target, @weeks).rates_in_db
  end

  def first_percentage_increase
    average_week = average_rate_per_week
    targets_array = target_rates_array
    ((average_week.first - targets_array.first) / targets_array.first) * 100
  end
end
