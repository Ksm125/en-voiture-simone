# frozen_string_literal: true

# Simple Model to Represent a price at a specific time
class Price < Struct.new(:time, :value)
  include Comparable

  def <=>(other)
    time <=> other.time || value <=> other.value
  end

  def ==(other)
    time == other.time && value == other.value
  end
end
