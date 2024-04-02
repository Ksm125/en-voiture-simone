# frozen_string_literal: true

class PotatoesController < ApplicationController
  def exchange_rate
    render json: PotatoesService.new(potato).daily_prices(date)
  end

  def best_gains
    render json: PotatoesService.new(potato).best_gains(date)
  end



  private

  def date
    params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def potato
    @potato ||= Potatoes.new
  end
end
