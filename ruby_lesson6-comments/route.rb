# Задание:
#
#     Разбить программу на отдельные классы (каждый класс в отдельном файле)
# Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, который будет содержать общие методы и свойства
# Определить, какие методы могут быть помещены в private/protected и вынести их в такую секцию. В комментарии к методу обосновать, почему он был вынесен в private/protected
# Вагоны теперь делятся на грузовые и пассажирские (отдельные классы). К пассажирскому поезду можно прицепить только пассажирские, к грузовому - грузовые.
#     При добавлении вагона к поезду, объект вагона должен передаваться как аругмент метода и сохраняться во внутреннем массиве поезда, в отличие от предыдущего задания, где мы считали только кол-во вагонов. Параметр конструктора "кол-во вагонов" при этом можно удалить.
#
#     Добавить текстовый интерфейс:
#
#                            Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
#                                                                                                                                         - Создавать станции
# - Создавать поезда
# - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
# - Назначать маршрут поезду
# - Добавлять вагоны к поезду
# - Отцеплять вагоны от поезда
# - Перемещать поезд по маршруту вперед и назад
# - Просматривать список станций и список поездов на станции
#
# В качестве ответа приложить ссылку на репозиторий с решением

require_relative 'valid_module'

class Route

  include Valid

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
  end

  # def to_s
  #   stations.each { |station| puts station }
  # end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def remove_station(station)
    self.delete(station)
  end

  def print_stations
    self.stations.each {|station| puts station.name}
  end

  protected


  def validate!
    raise "Station should be 'Station' type" if stations.any? {|station| !station.instance_of?(Station)}
    # raise "Station should be /'Station'/ type" unless stations.any?{|station| station.instance_of?(Station)}
    # Почему этот код не работает?
    raise "Station couldnt be empty" if stations.any? {|station| station.to_s.empty?}
  end
end
