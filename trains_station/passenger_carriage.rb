# Describe PassengerCarriage
class PassengerCarriage < Carriage
  attr_reader :seats_count, :taken_seats

  def initialize(seats_count, company_name)
    @seats_count = seats_count
    @taken_seats = 0
    super(company_name)
  end

  def take_a_seat
    self.taken_seats += 1 if taken_seats < seats_count
  end

  def free_seats_count
    seats_count - self.taken_seats
  end

  def type
    :passenger
  end

  def info
    "Type: #{type}, Taken Seats: #{taken_seats}, Free Seats: #{free_seats_count}"
  end

  protected

  attr_writer :taken_seats

  def validate!
    raise 'Company Name can`t be nil' if company_name.nil?
    raise 'Seats count can`t be nil' if seats_count.nil?
    raise 'Seats count must be number' if seats_count.class != Integer
  end
end
