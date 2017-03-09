class Route
  attr_accessor :stations
  attr_reader :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = []
  end

  def add_station(station)
    self.stations << station
  end

  def remove_station(station)
    self.stations.delete(station)
  end

  def list_stations
    [self.first_station] + self.stations + [self.last_station]
  end

  def show
    route = "#{@first_station} -> "
    self.stations.each { |station| route += "#{station.name} -> " }
    route += "#{@last_station}"
  end
end
