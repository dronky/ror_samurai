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
    if (1..2).include?(train_type)
      @trains << CargoTrain.new(train_number) if train_type == 1
      @trains << PassengerTrain.new(train_number) if train_type == 2
      break
    end
  end
rescue => e
  puts e.message
end

def create_route
  raise 'You must have at least 2 stations' if @stations.size < 2
  puts 'Which station will be first?'
  @stations.each_with_index {|station, i| puts "#{i + 1})#{station}"}
  station = @stations[gets.chomp.to_i - 1]
  if station
    first_station = station
    loop do
      puts 'Which station will be second?'
      @stations.select {|station| station != first_station}.each_with_index {|station, i| puts "#{i + 1})#{station}"}
      station = @stations.select {|station| station != first_station}[gets.chomp.to_i - 1]
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
  if (1..2).include?(vagon_type)
    @vagons << CargoVagon.new if vagon_type == 1
    @vagons << PassengerVagon.new if vagon_type == 2
  end
end

def manage_vagon
  raise 'You should add train or vagon at first.' unless @trains.size >= 1 && @vagons.size >= 1
  puts 'Choose an action:
                1) Add vagon
                2) Delete vagon'
  user_input = gets.chomp.to_i
  puts 'Choose a train:'
  @trains.each_with_index {|train, i| puts "#{i + 1})#{train}"}
  train = @trains[gets.chomp.to_i - 1]
  if user_input == 1
    puts 'Choose a vagon for adding:'
    @vagons.each_with_index {|vagon, i| puts "#{i + 1})#{vagon}"}
    vagon = @vagons[gets.chomp.to_i - 1]
    train.add_vagon(vagon)
  elsif user_input == 2
    train.remove_vagon
  end
end

def manage_station
  raise 'You should have at least 1 train and 1 route' if @trains.size < 1 && @routes.size < 1
  puts 'Choose a train:'
  @trains.each_with_index {|train, i| puts "#{i + 1})#{train}"}
  train = @trains[gets.chomp.to_i - 1]
  until train.route
    puts 'Choose a route:'
    @routes.each_with_index {|route, i| puts "#{i + 1}) Key @stations: #{route.stations.first} and #{route.stations.last}"}
    train.route = @routes[gets.chomp.to_i - 1]
  end
  puts "Current station is #{train.current_station}"
  puts 'Choose a destination:
                    1) Back
                    2) Forward'
  user_destination = gets.chomp.to_i
  until (1..2).include?(user_destination)
    puts 'Choose correct destination number.'
    user_destination = gets.chomp.to_i
  end
  if (1..2).include?(user_destination)
    train.depart(:back) if user_destination == 1
    train.depart(:forward) if user_destination == 2
  end
  puts "Current station is #{train.current_station}"
end

def list_stations
  raise 'There are no stations yet.' if @stations.size < 1
  puts "Whole list of stations: "
  @stations.each do |station|
    puts station
    station.print_trains
  end
end

def define_train_route
  raise 'No defined routes or trains' unless @routes.size != 0 && @trains.size != 0
    train = nil
    until train
      puts 'Choose a train:'
      @trains.each_with_index {|train, i| puts "#{i + 1})#{train}"}
      train = @trains[gets.chomp.to_i - 1]
    end
    until train.route
      puts 'Choose a route:'
      @routes.each_with_index {|route, i| puts "#{i + 1}) Key stations: #{route.stations.first} and #{route.stations.last}"}
      train.route = @routes[gets.chomp.to_i - 1]
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
    File.readlines('menu_items.txt').each_with_index {|line, index| puts "#{index + 1}. #{line}"}
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
    end
  rescue => e
    puts e.message
  ensure
    break if select == 9
    next
  end
end
# Сейчас для каждого методя я объявил свой обработчик исключений, есть ли способ пробрасывать текст исключения из родительского класса?
# Например, в опции "Создать поезд" выводится не заданный тут rescue, а resuce, заданный в классе Train, в методе validate! ?
# Ракетой (=>) я записываю в переменную текст ошибки? Как его потом достать? Можно ли в переменную записать текст ошибки из первичной валидации (см. предыдущий вопрос)? 
