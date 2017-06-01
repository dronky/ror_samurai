require_relative 'Train'
require_relative 'CargoTrain'
require_relative 'PassengerTrain'
require_relative 'Route'
require_relative 'Station'
require_relative 'CargoVagon'
require_relative 'PassengerVagon'

puts "Welcome to RZD Control Tool
            .---- -  -
           (   ,----- - -
            \\_/      ___
          c--U---^--'o  [_
          |------------'_|
         /_(o)(o)--(o)(o)
   ~ ~~~~~~~~~~~~~~~~~~~~~~~~ ~
"
stations = []
trains = []
routes = []
loop do
  puts '
  1. Create station
  2. Create train
  3. Create route
  0. exit'
  select = gets.chomp.to_i
  break if select == 0
  case select
    when 1
      puts "New station.\nName: "
      stations << Station.new(gets.chomp)
    when 2
      puts "New train.\nEnter number"
      train_number = gets.chomp
      loop do
        puts 'Select type:
        1) Cargo
        2) Passenger'
        train_type = gets.chomp.to_i
        if (1..2).include?(train_type)
          trains << CargoTrain.new(train_number) if train_type == 1
          trains << PassengerTrain.new(train_number) if train_type == 2
          break
        end
      end
    when 3
      if stations.size >= 2
        puts 'Which station will be first?'
        stations.each_with_index { |station, i| puts "#{i + 1})#{station}" }
        station = stations[gets.chomp.to_i - 1]
        if station
          first_station = station
          loop do
            puts 'Which station will be second?'
            stations.select { |station| station != first_station }.each_with_index { |station, i| puts "#{i + 1})#{station}" }
            station = stations.select { |station| station != first_station }[gets.chomp.to_i - 1]
            if station
              routes << Route.new(first_station, station)
              break
            end
          end
        end
      else
        puts 'You must have at least 2 stations'
      end
  end
end

puts "Routes: #{routes}"
puts "Stations: #{stations}"
puts "Trains #{trains}"

#
# #Create 4 stations
# primorsk = Station.new("primorsk")
# pochinki = Station.new("pochinki")
# gatka = Station.new("gatka")
# pushkino = Station.new("pushkino")
#
# #and 3 routes
# route1 = Route.new(primorsk,gatka)
# route1.add_station(pochinki)
#
# route2 = Route.new(gatka,pochinki)
#
# route3 = Route.new(pochinki,pushkino)
#
# #and 3 trains
# sapsan = PassengerTrain.new("813hfs211")
# tg16m = CargoTrain.new("tg16m-005")
# vityaz = CargoTrain.new("2te25am-019")
#
# #assign routes to trains
# #All trains go to pochinki
# sapsan.route = route1
# sapsan.add_vagon(PassengerVagon.new)
# sapsan.speed = 10
# sapsan.depart(:forward)
#
# tg16m.route = route2
# tg16m.add_vagon(CargoVagon.new)
# tg16m.add_vagon(CargoVagon.new)
# tg16m.depart(:forward)
#
# vityaz.route = route3
#
# #print trains at stations
# primorsk.print_trains
# pochinki.print_trains
# gatka.print_trains
# pushkino.print_trains
