# frozen_string_literal: true

# Service to handle potatoes data
class PotatoesService
  def initialize(potato)
    @potato = potato
  end

  # Get the daily prices of the potato for a given date
  def daily_prices(date)
    @potato.prices.select { |price| price.time.to_date == date.to_date }
  end
end
