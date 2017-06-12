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
    raise "You've reached the limit of volume" if self.reserved_volume + cubic_meter >= self.volume
    puts self.reserved_volume += cubic_meter
  end

  def free_volume?
    puts self.volume - self.reserved_volume
  end

  protected

  attr_writer :volume, :reserved_volume

  def validate!
    raise "Only numbers available" unless self.volume.instance_of?(Fixnum)
    raise "Volume field couldn't be zero" if self.volume.zero?
    true
  end
end
