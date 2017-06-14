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
    # rubymine подсказывает, что reduntant "self" detected, хотя в одном из скринкастов говорилось, что self надо писать обязательно. Где правда? :)
    @reserved_volume += cubic_meter
  end

  def free_volume?
    @volume - @reserved_volume
  end

  protected

  def validate!
    raise "Only numbers available" unless volume.instance_of?(Integer)
    # Сначала вместо Fixnum написал Integer, ориентировался на
    # As of Ruby 2.4, the Fixnum and Bignum classes are gone, there is only Integer. The exact same optimizations still exist, but they are treated as "proper" compiler optimizations, i.e. behind the scenes, invisible to the programmer.
    # Правильнее все-таки использовать Fixnum или Integer в таких случаях?
    raise "Volume field couldn't be zero" if volume.zero?
    true
  end
end
