class Station
  attr_reader :trains

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
    if Train::TYPE.include?(type)
      self.trains.map { |train| train.number if train.type == type }
    end
  end

  def remove_train(train)
    self.trains.delete(train)
  end
end
