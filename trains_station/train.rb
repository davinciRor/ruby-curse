require_relative 'station'
require_relative 'route'

class Train
  attr_accessor :speed, :carriage_count, :route, :current_station_index
  attr_reader :number, :type, :route

  TYPE = [:passanger, :cargo]

  def initialize(number, type, carriage_count = 1)
    @number = number
    @type = type
    @carriage_count = carriage_count
    @speed = 0
    @route = nil
    @current_station_index = 0
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
  end

  def current_station
    self.route.stations[current_station_index]
  end

  def next_station
    self.route.stations[current_station_index + 1]
  end

  def previus_station
    self.route.stations[current_station_index - 1] if current_station_index >= 1
  end

  def move_to_next_station
     self.current_station_index += 1 if next_station
  end
end
