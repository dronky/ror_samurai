# Класс Station (Станция):
# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

# Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

# Класс Train (Поезд):
# Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
# Может набирать скорость
# Может возвращать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может возвращать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route). 
# При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

class Station
	attr_reader :trains
	attr_reader :name

	def initialize(name)
		@trains = []
		@name = name
	end

	def add_train=(train)
		self.trains << train
	end

	def del_train=(train)
		self.trains.delete(train)
	end

	def type_trains(type)
		self.trains.select{|train| train.type == type}
	end

	def depart
		self.trains.first.depart(1)
	end

	def print_trains(type = "all")
		gruz = type_trains("gruz")
		pass = type_trains("pass")
		puts "\n#{self.name} trains:"
		if self.trains.size > 0
			if type == "all" 
				puts "Gruz trains: #{gruz.size} Pass trains: #{pass.size}"
				self.trains.each do |train| 
					puts "Train #{self.trains.index(train) + 1}: "
					train.print_train
				end
			elsif type == "gruz"
				gruz.each do |train|
					puts "Gruz train #{gruz.index(train) + 1}: "
					train.print_train
				end
			elsif type == "pass"
				pass.each do |train|
					puts "Pass train #{pass.index(train) + 1}: "
					train.print_train
				end
			else puts "wrong train type"
			end
		else puts "No trains in #{self.name}"
		end
	end
end


class Train
	attr_accessor :route, :speed, :number, :type, :vag_count
	def initialize(number,type,vag_count)
		@number = number
		@type = type
		@vag_count = vag_count
	end

	def route=(route)
		@route = route
		route.stations.first.add_train = self
	end

	def print_train
		puts "Number: #{self.number} Type: #{self.type} Vagons count: #{self.vag_count}"
	end

	def route_stations
		self.route.stations
	end

	def current_station
		route_stations.select{|station| station.trains.include?(self)}.first
	end

	def current_station_index
		route_stations.index(current_station)
	end

	def next_station
		route_stations[current_station_index + 1]
	end

	def previous_station
		route_stations[current_station_index - 1]
	end

	def stop
		self.speed = 0
	end

	def add_vagon
		if speed != 0
			puts "you must be stopped"
		else
			self.vag_count += 1
		end
	end

	def remove_vagon
		if vag_count == 0
			puts "you dont have vagons"
		elsif speed != 0
			puts "you must be stopped"
		else
			self.vag_count -= 1
		end
	end

	def depart(destination)
		if self.route != nil
			case destination
			when 1
				if current_station_index < route_stations.size-1
					next_station.add_train = self
			 		current_station.del_train = self
			 		self.stop
				else puts "you reached last station"
				end
			when -1
				if current_station_index > 0
					previous_station.add_train = self
					next_station.del_train = self	#cause methood current_station get first if one train in multiple stations
					self.stop
				else puts "you reached first station"
				end
			else
				puts "wrong destination! (#{destination}) It can be 1 or -1"
			end
		else puts "set route before depart"
		end
	end
end

class Route
	attr_reader :stations

	def initialize(start_station,end_station)
		@start_station = start_station
		@end_station = end_station
		@stations = [start_station,end_station]
	end

	def add_station=(station)
		self.stations.insert(-2,station)
	end

	def remove_station(station)
		self.delete(station)
	end

	def print_stations
		self.stations.each {|station| puts station.name}
	end
end

#Create 4 stations
primorsk = Station.new("primorsk")
pochinki = Station.new("pochinki")
gatka = Station.new("gatka")
pushkino = Station.new("pushkino")

#and 3 routes
route1 = Route.new(primorsk,gatka)
route1.add_station = pochinki

route2 = Route.new(gatka,pochinki)

route3 = Route.new(pochinki,pushkino)

#and 3 trains
sapsan = Train.new("813hfs211",'pass',2)
tg16m = Train.new("tg16m-005",'gruz',10)
vityaz = Train.new("2te25am-019",'gruz',13)

#assign routes to trains
#All trains go to pochinki
sapsan.route = route1
sapsan.speed = 10
sapsan.depart(1)

tg16m.route = route2
tg16m.depart(1)

vityaz.route = route3

#print trains at stations
primorsk.print_trains
pochinki.print_trains
gatka.print_trains
pushkino.print_trains

# pochinki.print_trains("gruz") #will print only gruz trains