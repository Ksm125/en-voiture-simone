# frozen_string_literal: true

class Potatoes
  def prices
    return @prices if @prices

    data = JSON.parse(json_data)
    @prices = data.map { |price| Price.new(Time.parse(price['time']), price['value']) }
  end

  private

  def json_data
    file_path = Rails.root.join('db', 'data', 'potato_prices.json')
    File.read(file_path)
  end
end
