require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'route'
require_relative 'station'
require_relative 'cargo_vagon'
require_relative 'passenger_vagon'

@stations = []
@trains = []
@routes = []
@vagons = []

def create_station
  puts "New station.\nName: "
  @stations << Station.new(gets.chomp)
rescue => e
  puts e.message
end

def create_train
  puts "New train.\nEnter number"
  train_number = gets.chomp
  loop do
    puts 'Select type:
            1) Cargo
            2) Passenger'
    train_type = gets.chomp.to_i
    next unless (1..2).cover?(train_type)
    @trains << CargoTrain.new(train_number) if train_type == 1
    @trains << PassengerTrain.new(train_number) if train_type == 2
    break
  end
rescue => e
  puts e.message
end

def create_route
  raise 'You must have at least 2 stations' if @stations.size < 2
  puts 'Which station will be first?'
  @stations.each_with_index { |station, i| puts "#{i + 1})#{station}" }
  station = @stations[gets.chomp.to_i - 1]
  if station
    first_station = station
    loop do
      puts 'Which station will be second?'
      @stations.reject { |s| s == first_station }.each_with_index { |s, i| puts "#{i + 1})#{s}" }
      station = @stations.reject { |s| s == first_station }[gets.chomp.to_i - 1]
      if station
        @routes << Route.new(first_station, station)
        break
      end
    end
  end
rescue => e
  puts e.message
end

def create_vagon
  puts 'Choose a vagon type:
                1) Gruz
                2) Pass'
  vagon_type = gets.chomp.to_i
  if vagon_type == 1
    puts 'Set a volume'
    volume = gets.chomp.to_i
    @vagons << CargoVagon.new(volume)
  end
  return unless vagon_type == 2
  puts 'Set a number of seats'
  number_seats = gets.chomp.to_i
  @vagons << PassengerVagon.new(number_seats)
end

def manage_vagon
  raise 'You should add train or vagon at first.' unless @trains.size >= 1 && @vagons.size >= 1
  puts 'Choose an action:
                1) Add vagon
                2) Delete vagon'
  user_input = gets.chomp.to_i
  puts 'Choose a train:'
  @trains.each_with_index { |train, i| puts "#{i + 1})#{train}" }
  train = @trains[gets.chomp.to_i - 1]
  if user_input == 1
    puts 'Choose a vagon for adding:'
    @vagons.each_with_index { |vagon, i| puts "#{i + 1})#{vagon}" }
    vagon = @vagons[gets.chomp.to_i - 1]
    train.add_vagon(vagon)
  elsif user_input == 2
    train.remove_vagon
  end
end

def manage_station
  raise 'You should have at least 1 train and 1 route' if @trains.empty? && @routes.empty?
  puts 'Choose a train:'
  @trains.each_with_index { |train, i| puts "#{i + 1})#{train}" }
  train = @trains[gets.chomp.to_i - 1]
  until train.route
    puts 'Choose a route:'
    @routes.each_with_index { |route, i| puts "#{i + 1}) Key @stations: #{route.stations.first} and #{route.stations.last}" }
    train.route = @routes[gets.chomp.to_i - 1]
  end
  puts "Current station is #{train.current_station}"
  puts 'Choose a destination:
                    1) Back
                    2) Forward'
  user_destination = gets.chomp.to_i
  until (1..2).cover?(user_destination)
    puts 'Choose correct destination number.'
    user_destination = gets.chomp.to_i
  end
  if (1..2).cover?(user_destination)
    train.depart(:back) if user_destination == 1
    train.depart(:forward) if user_destination == 2
  end
  puts "Current station is #{train.current_station}"
end

def list_stations
  raise 'There are no stations yet.' if @stations.empty?
  puts 'Whole list of stations: '
  @stations.each do |station|
    puts station
    station.print_trains
  end
end

def define_train_route
  raise 'No defined routes or trains' unless !@routes.empty? && !@trains.empty?
  train = nil
  until train
    puts 'Choose a train:'
    @trains.each_with_index { |t, i| puts "#{i + 1})#{t}" }
    train = @trains[gets.chomp.to_i - 1]
  end
  until train.route
    puts 'Choose a route:'
    @routes.each_with_index { |route, i| puts "#{i + 1}) Key stations: #{route.stations.first} and #{route.stations.last}" }
    train.route = @routes[gets.chomp.to_i - 1]
  end
end

def show_vagons_for_train
  raise 'You should define train and vagon at first' if @trains.empty? && @vagons.empty?
  puts 'Choose a train:'
  @trains.each_with_index { |t, i| puts "#{i + 1})#{t}" }
  train = @trains[gets.chomp.to_i - 1]
  train.each do |i|
    puts "Vagon type: #{i.type}"
    case i.type
    when :cargo
      puts "Vagon volume: #{i.volume}"
      puts "Reserved volume: #{i.reserved_volume}"
    when :pass
      puts "Number of seats: #{i.number_seates}"
      puts "Number of reserved seats: #{i.reserved_seats}"
    end
  end
end

def edit_vagon
  raise 'You should create at least one vagon before edit' if @vagons.empty?
  puts 'Choose a vagon:'
  @vagons.each_with_index { |vagon, i| puts "#{i + 1})#{vagon}" }
  user_vagon = @vagons[gets.chomp.to_i - 1]
  if user_vagon.type == :cargo
    puts 'Set a volume for adding'
    added_volume = gets.chomp.to_i
    user_vagon.add_volume(added_volume)
  elsif user_vagon.type == :pass
    user_vagon.add_seat
    puts "One seat has been reserved. Remains seats for reserve: #{user_vagon.free_seats?}."
  end
end

puts "Welcome to RZD Control Tool
                .---- -  -
               (   ,----- - -
                \\_/      ___
              c--U---^--'o  [_
              |------------'_|
             /_(o)(o)--(o)(o)
       ~ ~~~~~~~~~~~~~~~~~~~~~~~~ ~
    "

loop do
  begin
    File.readlines('menu_items.txt').each_with_index { |line, index| puts "#{index + 1}. #{line}" }
    select = gets.chomp.to_i
    case select
    when 1
      create_station
    when 2
      create_train
    when 3
      create_route
    when 4
      create_vagon
    when 5
      manage_vagon
    when 6
      manage_station
    when 7
      list_stations
    when 8
      define_train_route
    when 9
      show_vagons_for_train
    when 10
      edit_vagon
    end
  rescue => e
    puts e.message
  ensure
    break if select == 11
    next
  end
end
