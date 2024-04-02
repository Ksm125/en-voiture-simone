# frozen_string_literal: true

# Help to generate dataset for the application
# Data can be generated for a specific time and have format of a hash
# {
#   time: Time.zone.now,
#   value: 100.2
# }
module DataGenerator
  module_function

  # Generate a list of prices for a specific time range
  # @param start_time [Time] the start time of the range
  # @param end_time [Time] the end time of the range
  # @param step [Integer] the step between each price
  def generate_for_time_range(start_time, end_time = Time.zone.now, step = 1.hour)
    (start_time.to_i..end_time.to_i).step(step).map do |time|
      generate_for_time(Time.zone.at(time))
    end

  end

  def generate_for_time(time)
    Price.new(time, rand(1000))
  end
  private_class_method :generate_for_time
end
