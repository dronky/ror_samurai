require_relative 'vagon'
require_relative 'module_validation'

class CargoVagon < Vagon
  extend Validation
  attr_reader :volume, :reserved_volume

  validate :volume, :type, Integer

  def initialize(volume)
    super(:cargo)
    @volume = volume.to_i
    @reserved_volume = 0
    validate!
  end

  def add_volume(cubic_meter)
    raise "You've reached the limit of volume" if reserved_volume + cubic_meter >= volume
    @reserved_volume += cubic_meter
  end

  def free_volume?
    @volume - @reserved_volume
  end
end