class Route
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def remove_station(station)
    self.stations.delete(station)
  end

  def show
    puts self.stations.map(&:name)
  end
end
