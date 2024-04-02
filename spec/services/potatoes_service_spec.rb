# frozen_string_literal: true

require 'spec_helper'

describe PotatoesService do
  let(:potato) { Potatoes.new }

  before do
    allow(potato).to receive(:prices).and_return([
                                                   Price.new(Time.parse('2021-01-01 00:00:00'), 100),
                                                   Price.new(Time.parse('2021-01-02 00:00:00'), 200),
                                                   Price.new(Time.parse('2021-01-02 01:00:00'), 300),
                                                   Price.new(Time.parse('2021-01-03 00:00:00'), 300)
                                                 ])
  end

  describe '#daily_prices' do
    it 'returns the daily prices of the potato for a given date' do
      service = PotatoesService.new(potato)

      date = Date.parse('2021-01-02')
      prices = service.daily_prices(date)

      expect(prices.size).to eq(2)
      expect(prices).to eq([
                             Price.new(Time.parse('2021-01-02 00:00:00'), 200),
                             Price.new(Time.parse('2021-01-02 01:00:00'), 300)])
    end
  end
end
