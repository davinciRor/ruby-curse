class CargoCarriage < Carriage
  attr_reader :total_volume, :taken_volume

  def initialize(total_volume, company_name)
    @total_volume = total_volume
    @taken_volume = 0
    super(company_name)
  end

  def take_volume(volume)
    self.taken_volume += volume if self.total_volume - volume >= self.taken_volume
  end

  def available_volume
    self.total_volume - self.taken_volume
  end

  def info
    "Type: #{self.type}, Taken Volume: #{self.taken_volume}, Avilable: #{available_volume}"
  end

  def type
    :cargo
  end

  protected

  attr_writer :taken_volume
end
