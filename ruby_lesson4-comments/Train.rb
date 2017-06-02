class Train

  attr_accessor :route, :speed, :number, :type, :current_station, :vagons

  def route=(route)
    @route = route
    route.stations.first.add_train(self)
  end

  def initialize(number,type)
    @number = number
    @type = type
    @speed = 0
    @vagons = []
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
      vagons << vagon
    else
      puts "Only #{self.type} vagon type is availible."
    end
  end

  def remove_vagon
    if self.vagons.size > 1
      vagons.delete(vagons.last)
    end
  end

  def depart(destination)
    if self.route != nil
      case destination
        when :forward
          if !at_last_station?
            next_station.add_train(self)
            previous_station.del_train(self)
          else
            puts "you reached last station"
            return
          end
        when :back
          if !at_first_station?
            previous_station.add_train(self)
            next_station.del_train(self) #cause methood current_station get first if one train in multiple stations
          else
            puts "you reached first station"
            return
          end
        else
          puts "wrong destination! (#{destination}) It can be :forward or :back"
          return
      end
      self.stop
    else
      puts "set route before depart"
    end
  end

  protected

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