require_relative 'vagon'

class CargoVagon < Vagon
  attr_reader :volume, :reserved_volume

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

  protected

  def validate!
    raise 'Only numbers available' unless volume.instance_of?(Integer)
    raise "Volume field couldn't be zero" if volume.zero?
    true
  end
end
