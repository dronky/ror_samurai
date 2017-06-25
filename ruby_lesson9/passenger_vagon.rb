require_relative 'vagon'
require_relative 'modules/module_validation'

class PassengerVagon < Vagon
  include Validation
  attr_reader :number_seates, :reserved_seats

  validate :number_seates, :type, Fixnum

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
end