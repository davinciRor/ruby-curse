# Describe station
class Station
  attr_reader :trains, :name
  @instanses = []

  def initialize(name)
    @name = name
    @trains = []
    validate!
    instanses << self
  end

  def add_train(train)
    trains << train
  end

  def trains_list
    trains.map(&:number).join(' ')
  end

  def trains_list_by_type(type)
    trains.select { |c_train| c_train.type == type }.join(' ')
  end

  def remove_train(train)
    trains.delete(train)
  end

  def each_train
    trains.each { |train| yield(train) }
  end

  def valid?
    validate!
  rescue
    false
  end

  def instanses
    self.class.instanses
  end

  class << self
    attr_reader :instanses

    def all
      instanses
    end
  end

  private

  attr_writer :trains

  def validate!
    raise 'Name can`t be nil' if name.nil?
    raise 'Name should be at least 2 symbols' if name.length < 2
    true
  end
end
