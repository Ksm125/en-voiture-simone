# frozen_string_literal: true

require 'spec_helper'

describe 'Potatoes Endpoint' do
  let(:potato) { Potatoes.new }

  before do
    allow_any_instance_of(Potatoes).to receive(:json_data).and_return(File.read(Rails.root.join('spec', 'fixtures', 'potato_prices.json')))
  end

  describe '#potatoes/exchange_rate' do
    it 'returns the daily prices of the potato for a given date' do
      get '/potatoes/exchange_rate', params: { date: '2021-01-02' }

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq([
                                    { time: Time.parse('2021-01-02 00:00:00'), value: 200 },
                                    { time: Time.parse('2021-01-02 01:00:00'), value: 300 },
                                    { time: Time.parse('2021-01-02 02:00:00'), value: 800 }
                                  ].to_json)
    end

    it 'returns the daily prices of the potato for today' do
      Timecop.freeze(Time.parse('2021-01-03 12:00:00')) do
        get '/potatoes/exchange_rate'

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq([
                                      { time: Time.parse("2021-01-03 00:00:00 +0100"), value: 300 },
                                    ].to_json)
      end
    end
  end
end
