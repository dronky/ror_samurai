# Класс Station (Станция):
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
class Station
	#attr_accessor :trains[]
	attr_reader :trains
	attr_reader :name
	def initialize(name)
		@trains = []
		@name = name
	end
	def trains=(train)
		@trains << train
	end
	def type_trains(type)
		self.trains.select{|train| train.type == type}
	end
	def depart
		self.trains[0].depart(1)
	end
end


class Train
	attr_accessor :route
	attr_accessor :speed
	def initialize(number,type,vag_count)
		@number = number
		@type = type
		@vag_count = vag_count
	end
	def route_progress
		self.route
	end
end

class Route
	attr_accessor :stations
	def initialize(start_station,end_station)
		@start_station = start_station
		@end_station = end_station
		@stations = [start_station,end_station]
	end
	def stations=(station)
		@stations.insert(-2,station)
	end
end

primorsk = Station.new("primorsk")
pochinki = Station.new("pochinki")
gatka = Station.new("gatka")
route1 = Route.new(primorsk,gatka)
route1.stations = pochinki
sapsan = Train.new("813hfs211","pass",4)
sapsan.route = route1
sapsan.route.stations.each {|station| puts station.name}