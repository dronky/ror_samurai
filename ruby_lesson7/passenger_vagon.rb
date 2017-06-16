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
    raise "You've reached the limit of seats" if reserved_seats + 1 >= number_seates
    @reserved_seats += 1
  end

  def free_seats?
    @number_seates - @reserved_seats
  end

  protected

  def validate!
    raise 'Only numbers available' unless number_seates.instance_of?(Integer)
    raise "Number_seats field couldn't be zero" if number_seates.zero?
    true
  end
end
