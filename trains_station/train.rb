require_relative 'station'
require_relative 'route'

class Train
  attr_reader :number, :speed, :route, :current_station_index, :carriages

  def initialize(number)
    @number = number
    @carriages = []
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

  def add_carriage(carriage)
    self.carriages << carriage if speed == 0 && carriage.type == type
  end

  def remove_carriage
    self.carriages.delete_at(-1) if speed == 0
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

  def type
    raise NotImplementedError, 'Sorry, you have to override type'
  end

  private

  attr_writer :speed, :route, :current_station_index, :carriages
end
