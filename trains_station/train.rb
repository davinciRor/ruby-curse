require_relative 'company'

class Train
  include Company
  @@instanses = {}

  NUMBER_FORMAT = /^(\d|[a-z]){3}-?((\d{2})|([a-z]{2}))$/i

  attr_reader :number, :speed, :route, :current_station_index, :carriages

  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    @route = nil
    @current_station_index = 0
    validate!
    @@instanses[number] = self
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

  def each_carriage(&block)
    self.carriages.each { |carriage| block.(carriage) }
  end

  def type
    raise NotImplementedError, 'Sorry, you have to override type'
  end

  def valid?
    validate!
  rescue
    false
  end

  class << self
    def all
      @@instanses
    end

    def find(number)
      @@instanses[number]
    end
  end

  protected

  attr_writer :speed, :route, :current_station_index, :carriages

  def validate!
    raise 'Number can`t be nil' if number.nil?
    raise 'Number has invalid format' if number !~ NUMBER_FORMAT
    true
  end
end
