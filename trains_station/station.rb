# Describe station
class Station
  include Validation

  attr_reader :trains, :name

  validate :name, :presence

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
end
