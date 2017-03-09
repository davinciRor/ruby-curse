require_relative 'station'
require_relative 'route'

class Train
  attr_accessor :speed, :carriage_count, :route, :current_station
  attr_reader :number, :type, :route

  TYPE = [:passanger, :cargo]

  def initialize(number, type, carriage_count = 1)
    @number = number
    @type = type
    @carriage_count = carriage_count
    @speed = 0
    @route = nil
    @current_station = nil
  end

  def accelerate(speed = 10)
    self.speed = speed
  end

  def slow_down(speed = 0)
    self.speed = speed
  end

  def add_carriage
    self.carriage_count += 1 if speed == 0
  end

  def remove_carriage
    self.carriage_count -= 1 if speed == 0 && carriage_count > 1
  end

  def add_route(route)
    self.route = route
    self.current_station = route.first_station
    self.route
  end

  def next_station
    next_station = nil
    stations = self.route.list_stations
    stations.each_with_index do |element, index|
      if element == self.current_station
        next_station = stations[index+1]
      end
    end
    next_station
  end

  def previus_station
    prev_station = nil
    stations = self.route.list_stations
    stations.each_with_index do |element, index|
      if element == self.current_station && index >= 1
        prev_station = stations[index-1]
      end
    end
    prev_station
  end

  def move_to_next_station
    self.current_station = next_station if next_station
  end
end
