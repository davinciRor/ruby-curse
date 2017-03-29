# Describe PassengerCarriage
class PassengerCarriage < Carriage
  attr_reader :seats_count, :taken_seats

  validate :seats_count, :presence
  validate :seats_count, :type, Fixnum

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
end
