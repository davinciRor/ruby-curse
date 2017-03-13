class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    self.trains << train
  end

  def trains_list
    puts self.trains.map(&:number)
  end

  def trains_list_by_type(type)
    case type
    when :cargo
      self.trains.select { |c_train| c_train.type == :cargo }
    when :passenger
      self.trains.select { |c_train| c_train.type == :passenger }
    end
  end

  def remove_train(train)
    self.trains.delete(train)
  end

  private
  # Нельзя менять масив поездов на станции из вне
  attr_writer :trains
end
