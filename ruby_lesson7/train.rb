require_relative 'module_vendor_name'
require_relative 'module_instance_counter'
require_relative 'valid_module'

class Train

  include VendorName
  include InstanceCounter
  include Valid

  attr_accessor :route, :speed, :number, :type, :current_station, :vagons

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  @@all = []

  def self.all
    @@all
  end

  def self.find_train_by_num(num)
    @@all.find {|train| train.number == num}
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
    validate!
    @type = type
    @speed = 0
    @vagons = []
    @@all << self
    register_instance
  end

  def to_s
    "Number: #{self.number} Type: #{self.type} Vagons count: #{self.vagons.size()}"
  end

  def increase_speed(speed_gain)
    self.speed += speed_gain if speed_gain > 0
  end

  def stop
    self.speed = 0
  end

  def add_vagon(vagon)
    if self.type == vagon.type
      if self.speed == 0
        vagons << vagon
      else
        raise 'stop train before'
      end
    else
      raise "Only #{self.type} vagon type is availible."
    end
  end

  def remove_vagon
    if self.vagons.size > 1
      if self.speed == 0
        vagons.delete(vagons.last)
      else
        raise 'stop train before'
      end
    end
  end

  def move_next_station
    unless at_last_station?
      add_train_to_station(self.next_station)
      previous_station.del_train(self)
    else
      puts "you reached last station"
      return
    end
  end

  def move_previous_station
    unless at_first_station?
      add_train_to_station(self.previous_station)
      next_station.del_train(self) #cause methood current_station get first if one train in multiple stations
    else
      puts "you reached first station"
      return
    end
  end

  def depart(destination)
    if self.route != nil
      case destination
        when :forward
          move_next_station
        when :back
          move_previous_station
        else
          raise "wrong destination! (#{destination}) It can be :forward or :back"
          return
      end
      self.stop
    else
      raise "set route before depart"
    end
  end

  protected

  def validate!
    raise 'Incorrect number format' if number.to_s !~ NUMBER_FORMAT
    @@all.each do |train|
      if train.number == number
        raise 'Same number exists. Choose another one.'
      end
    end
    # rescue => train_validate_error
    #   puts "Error has been added to the logs."
    # После выполнения этого кода(закомментированого) все-равно создается объект, хотя мы выкидываем исключение в строчке 123, почему?
  end

  def current_station_index
    self.route.stations.index(current_station)
  end

  def next_station
    self.route.stations[current_station_index + 1]
  end

  def previous_station
    self.route.stations[current_station_index - 1]
  end

  def at_last_station?
    current_station_index == self.route.stations.size - 1
  end

  def at_first_station?
    current_station_index == 0
  end
end
