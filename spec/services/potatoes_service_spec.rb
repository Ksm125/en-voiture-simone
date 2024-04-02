# frozen_string_literal: true

require 'spec_helper'

describe PotatoesService do
  let(:potato) { Potatoes.new }

  before do
    allow_any_instance_of(Potatoes).to receive(:json_data).and_return(File.read(Rails.root.join('spec', 'fixtures', 'potato_prices.json')))
  end

  describe '#daily_prices' do
    it 'returns the daily prices of the potato for a given date' do
      service = PotatoesService.new(potato)

      date = Date.parse('2021-01-02')
      prices = service.daily_prices(date)

      expect(prices.size).to eq(3)
      expect(prices).to eq([
                             Price.new(Time.parse('2021-01-02 00:00:00'), 200),
                             Price.new(Time.parse('2021-01-02 01:00:00'), 300),
                             Price.new(Time.parse('2021-01-02 02:00:00'), 800)])
    end
  end
end
