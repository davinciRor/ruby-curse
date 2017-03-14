class Station
  attr_reader :trains, :name
  @@instanses = []

  def initialize(name)
    @name = name
    @trains = []
    @@instanses << self
  end

  def add_train(train)
    self.trains << train
  end

  def trains_list
    self.trains.map(&:number).join(' ')
  end

  def trains_list_by_type(type)
    self.trains.select { |c_train| c_train.type == type }.join(' ')
  end

  def remove_train(train)
    self.trains.delete(train)
  end

  class << self
    def all
      @@instanses
    end
  end

  private
  # Нельзя менять масив поездов на станции из вне
  attr_writer :trains
end
