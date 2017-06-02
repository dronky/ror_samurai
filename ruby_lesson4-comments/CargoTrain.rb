require_relative 'Train'

class CargoTrain < Train

  def initialize(number)
    super(number, "gruz")
  end

end