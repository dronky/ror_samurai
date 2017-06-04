require_relative 'Train'

class PassengerTrain < Train

  def initialize(number)
    super(number, :pass)
  end

end
