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

  describe '#best_gains' do
    it 'returns the best gains of the potato for a given date' do
      service = PotatoesService.new(potato)

      date = Date.parse('2021-01-02')
      gains = service.best_gains(date)

      expect(gains).to eq(
        buy: Price.new(Time.parse('2021-01-02 00:00:00'), 200),
        sell: Price.new(Time.parse('2021-01-02 02:00:00'), 800),
        best_gain: "#{PotatoesService::MAX_POTATOES * (800 - 200)}#{PotatoesService::GAINS_CURRENCY}"
      )
    end

    it 'returns 0 if there are less than 2 prices' do
      service = PotatoesService.new(potato)

      date = Date.parse('2021-01-03')
      gains = service.best_gains(date)

      expect(gains).to eq({ buy: nil, sell: nil, best_gain: '0€'})
    end
  end
end
