require_relative 'vagon'

class PassengerVagon < Vagon

  attr_reader :number_seates, :reserved_seats

  def initialize(number_seats)
    super(:pass)
    @number_seates = number_seats.to_i
    @reserved_seats = 0
    validate!
  end

  def add_seat
    validate!
    puts self.reserved_seats += 1
  end

  def free_seats?
    puts self.number_seates - self.reserved_seats
  end

  protected

  attr_writer :number_seates, :reserved_seats

  def validate!
    raise "Only numbers available" unless self.number_seates.instance_of?(Fixnum)
    raise "Number_seats field couldn't be zero" if self.number_seates.zero?
    raise "You've reached the limit of seats" if self.reserved_seats + 1 >= self.number_seates
    true
  end
end
