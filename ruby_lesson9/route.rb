require_relative 'modules/module_validation'

class Route
  include Validation

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    delete(station)
  end

  def print_stations
    stations.each { |station| puts station.name }
  end

  protected

  # def validate!
  #   raise "Station should be 'Station' type" if stations.any? { |station| !station.instance_of?(Station) }
  #   raise 'Station couldnt be empty' if stations.any? { |station| station.to_s.empty? }
  # end
end
