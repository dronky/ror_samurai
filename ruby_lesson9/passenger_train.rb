require_relative 'train'
require_relative 'modules/module_validation'

class PassengerTrain < Train
  include Validation

  validate :number, :format, NUMBER_FORMAT
  validate :type, :type, Symbol

  def initialize(number)
    super(number, :pass)
    validate!
  end
end
