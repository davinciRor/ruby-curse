class Station
  attr_reader :trains, :name
  @@instanses = []

  def initialize(name)
    @name = name
    @trains = []
    validate!
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

  def valid?
    validate!
  rescue
    false
  end

  class << self
    def all
      @@instanses
    end
  end

  private
  # Нельзя менять масив поездов на станции из вне
  attr_writer :trains

  def validate!
    raise 'Name can`t be nil' if name.nil?
    raise 'Name should be at least 2 symbols' if name.length < 2
    true
  end
end
