# frozen_string_literal: true

class PotatoesController < ApplicationController
  def exchange_rate
    date = params[:date] ? Date.parse(params[:date]) : Date.today
    render json: PotatoesService.new(potato).daily_prices(date)
  end



  private

  def potato
    @potato ||= Potatoes.new
  end
end
