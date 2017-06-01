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
vagons = []

loop do
  puts '
      1. Create station
      2. Create train
      3. Create route
      4. Create vagon
      5. Managing vagons (add or delete)
      6. Managing stations for train (move back or forward)
      7. List of stations
      8. Define train route
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
    when 4
      puts 'Choose a vagon type:
                1) Gruz
                2) Pass'
      vagon_type = gets.chomp.to_i
      if (1..2).include?(vagon_type)
        vagons << CargoVagon.new if vagon_type == 1
        vagons << PassengerVagon.new if vagon_type == 2
      end
    when 5
      if trains.size >= 1 && vagons.size >= 1
        puts 'Choose an action:
                1) Add vagon
                2) Delete vagon'
        user_input = gets.chomp.to_i
        puts 'Choose a train:'
        trains.each_with_index { |train, i| puts "#{i + 1})#{train}" }
        train = trains[gets.chomp.to_i - 1]
        if user_input == 1
          puts 'Choose a vagon for adding:'
          vagons.each_with_index { |vagon, i| puts "#{i + 1})#{vagon}" }
          vagon = vagons[gets.chomp.to_i - 1]
          train.add_vagon(vagon)
        elsif user_input == 2
          train.remove_vagon
        end
      else
        puts 'You should add train or vagon at first.'
      end
    when 6
      if trains.size >= 1 && routes.size >= 1
        puts 'Choose a train:'
        trains.each_with_index { |train, i| puts "#{i + 1})#{train}" }
        train = trains[gets.chomp.to_i - 1]
        while !train.route
          puts 'Choose a route:'
          routes.each_with_index { |route, i| puts "#{i + 1}) Key Stations: #{route.stations.first} and #{route.stations.last}" }
          train.route = routes[gets.chomp.to_i - 1]
        end
        puts "Current station is #{train.current_station}"
        puts 'Choose a destination:
                    1) Back
                    2) Forward'
        user_destination = gets.chomp.to_i
        while !(1..2).include?(user_destination)
          puts 'Choose correct destination number.'
          user_destination = gets.chomp.to_i
        end
        if (1..2).include?(user_destination)
          train.depart(:back) if user_destination == 1
          train.depart(:forward) if user_destination == 2
        end
        puts "Current station is #{train.current_station}"
      end
    when 7
      if stations.size >= 1
        puts "Whole list of stations: "
        stations.each do |station|
          puts station
          station.print_trains
        end
      else
        puts 'There are no stations yet.'
      end
    when 8
      train = nil
      while !train
        puts 'Choose a train:'
        trains.each_with_index { |train, i| puts "#{i + 1})#{train}" }
        train = trains[gets.chomp.to_i - 1]
      end
      while !train.route
        puts 'Choose a route:'
        routes.each_with_index { |route, i| puts "#{i + 1}) Key Stations: #{route.stations.first} and #{route.stations.last}" }
        train.route = routes[gets.chomp.to_i - 1]
      end
  end
end