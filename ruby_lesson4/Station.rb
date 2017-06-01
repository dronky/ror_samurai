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
    if type
      @trains.select{|train| train.type == type}
    else
      @trains
    end
  end

  def to_s
    "Station: #{self.name}"
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