require_relative 'Train'

class CargoTrain < Train

  def initialize(number)
    super(number, :cargo)
  end

end