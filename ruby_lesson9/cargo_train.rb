require_relative 'train'
require_relative 'modules/module_validation'

class CargoTrain < Train
  include Validation

  attr_accessor :type_car, :number_car

  validate self.number_car, :format, NUMBER_FORMAT
  # validate :type_car, :type, Symbol

  def initialize(number)
    validate!
    @type_car = :cargo
    @number_car = number
    super(@number_car, @type_car)
  end
end

a = CargoTrain.new("aaaaa")
puts :number_car