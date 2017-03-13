class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def remove_station(station)
    self.stations.delete(station)
  end

  private
  # Нельзя менять масив станций из вне
  attr_writer :stations

  def show
    puts self.stations.map(&:name)
  end
end
