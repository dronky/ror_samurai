require_relative 'modules/module_vendor_name'
require_relative 'modules/module_instance_counter'

class Train
  include VendorName
  include InstanceCounter

  attr_accessor :route, :speed, :number, :type, :current_station, :vagons
  attr_reader :all

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  @@all = []

  class << self
    @@all
  end

  def each(&block)
    vagons.each(&block)
  end

  def self.find_train_by_num(num)
    @@all.find { |train| train.number == num }
  end

  def route=(route)
    @route = route
    add_train_to_station(route.stations.first)
  end

  def add_train_to_station(station)
    self.current_station = station
    station.trains << self
  end

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @vagons = []
    @@all << self
    register_instance
  end

  def to_s
    "Number: #{number} Type: #{type} Vagons count: #{vagons.size}"
  end

  def increase_speed(speed_gain)
    self.speed += speed_gain if speed_gain > 0
  end

  def stop
    self.speed = 0
  end

  def add_vagon(vagon)
    if type == vagon.type
      if self.speed.zero?
        vagons << vagon
      else
        raise 'stop train before'
      end
    else
      raise "Only #{type} vagon type is availible."
    end
  end

  def remove_vagon
    if vagons.size > 1
      if self.speed.zero?
        vagons.delete(vagons.last)
      else
        raise 'stop train before'
      end
    end
  end

  def move_next_station
    if at_last_station?
      puts 'you reached last station'
      nil
    else
      add_train_to_station(next_station)
      previous_station.del_train(self)
    end
  end

  def move_previous_station
    if at_first_station?
      puts 'you reached first station'
      nil
    else
      add_train_to_station(previous_station)
      next_station.del_train(self)
    end
  end

  def depart(destination)
    if !route.nil?
      case destination
      when :forward
        move_next_station
      when :back
        move_previous_station
      else
        raise "wrong destination! (#{destination}) It can be :forward or :back"
      end
      stop
    else
      raise 'set route before depart'
    end
  end

  protected

  def current_station_index
    route.stations.index(current_station)
  end

  def next_station
    route.stations[current_station_index + 1]
  end

  def previous_station
    route.stations[current_station_index - 1]
  end

  def at_last_station?
    current_station_index == route.stations.size - 1
  end

  def at_first_station?
    current_station_index.zero?
  end
end