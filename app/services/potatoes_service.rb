# frozen_string_literal: true

# Service to handle potatoes data
class PotatoesService
  MAX_POTATOES = 100
  GAINS_CURRENCY = '€'

  def initialize(potato)
    @potato = potato
  end

  # Get the daily prices of the potato for a given date
  def daily_prices(date)
    @potato.prices.select { |price| price.time.to_date == date.to_date }.sort_by(&:time)
  end

  # Return the best gains of the potato for a given date
  # The best gains are the prices that have the highest difference between them
  # Knowing that i can only buy 100 potatoes and sell them at the end of the day
  def best_gains(date)
    prices = daily_prices(date)
    # We can't have any gain if we have less than 2 prices
    if prices.size < 2
      return {
        buy: nil,
        sell: nil,
        best_gain: "0#{GAINS_CURRENCY}"
      }
    end

    best_buy = prices[0]
    best_sell = prices[1]
    best_gain = (best_sell.value - best_buy.value) * MAX_POTATOES

    i = 0 # Start from the second price since we already have the first price
    while i < prices.size
      j = i + 1
      while j < prices.size
        buy = prices[i]
        sell = prices[j]
        gain = (sell.value - buy.value) * MAX_POTATOES
        if gain > best_gain
          best_gain = gain
          best_buy = buy
          best_sell = sell
          # we can skip the next prices since we already have the best buy and sell.
          # There is no need to check the prices between the best buy and sell since we can't have a better gain
          i = j + 1
        end
        j += 1
      end
      i += 1
    end

    {
      buy: best_buy,
      sell: best_sell,
      best_gain: "#{best_gain}#{GAINS_CURRENCY}"
    }
  end
end
