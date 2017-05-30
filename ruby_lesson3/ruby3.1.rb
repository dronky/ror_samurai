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

	def add_train(train)
		train.current_station = self
		self.trains << train
	end

	def del_train(train)
		self.trains.delete(train)
	end

	def trains(type = nil)
		if type != nil 
			@trains.select{|train| train.type == type}
		else
			@trains
		end
	end

	def depart
		self.trains.first.depart(:forward)
	end

	def print_train(type = nil)
		trains(type).each_with_index do |train, i| 
			puts "Train #{i + 1}: "
			puts train
		end
	end

	def print_trains(type = nil)
		puts "\n#{self.name} trains:"
		if self.trains.size > 0
			case type
			when nil
				puts "Gruz trains: #{trains("gruz").size} Pass trains: #{trains("pass").size}"
			when "gruz"
				puts "Gruz trains: #{trains("gruz").size}"
			when "pass"
				puts "Pass trains: #{trains("pass").size}"
			else 
				puts "wrong train type"
				return
			end
			print_train(type)
		else 
			puts "No trains in #{self.name}"
		end
	end
end


class Train
	attr_accessor :route, :speed, :number, :type, :vag_count, :current_station
	def initialize(number,type)
		@number = number
		@type = type
		@vag_count = 0
		@speed = 0
	end

	def route=(route)
		@route = route
		route.stations.first.add_train(self)
	end

	def to_s
		"Number: #{self.number} Type: #{self.type} Vagons count: #{self.vag_count}"
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

	def increase_speed(speed_gain)
		self.speed += speed_gain if speed_gain > 0
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

	def last_station_reached
		current_station_index == self.route.stations.size - 1
	end

	def depart(destination)
		if self.route != nil
			case destination
			when :forward
				if !last_station_reached
					next_station.add_train(self)
			 		previous_station.del_train(self)
				else 
					puts "you reached last station"
					return
				end
			when :back
				if current_station_index > 0
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
end

class Route
	attr_reader :stations

	def initialize(start_station,end_station)
		@stations = [start_station,end_station]
	end

	def add_station(station)
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
route1.add_station(pochinki)

route2 = Route.new(gatka,pochinki)

route3 = Route.new(pochinki,pushkino)

#and 3 trains
sapsan = Train.new("813hfs211",'pass')
tg16m = Train.new("tg16m-005",'gruz')
vityaz = Train.new("2te25am-019",'gruz')

#assign routes to trains
#All trains go to pochinki
sapsan.route = route1
sapsan.add_vagon
sapsan.speed = 10
sapsan.depart(:forward)

tg16m.route = route2
tg16m.add_vagon
tg16m.add_vagon
tg16m.depart(:forward)

vityaz.route = route3

#print trains at stations
primorsk.print_trains
pochinki.print_trains
gatka.print_trains
pushkino.print_trains

# pochinki.print_trains("gruz") #will print only gruz trains