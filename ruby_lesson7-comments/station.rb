require_relative 'module_instance_counter'
require_relative 'valid_module'

class Station

  include InstanceCounter
  include Valid

  attr_reader :name
  attr_accessor :trains

  NAME_FORMAT = /^[a-z]*$/i

  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(name)
    @trains = []
    @name = name
    @@all_stations << self
    validate!
  end

  # def add_train(train)
  #   train.current_station = self
  #   self.trains << train
  # end

  def each_train(block)
    trains.each { block.call }
  end

  def del_train(train)
    self.trains.delete(train)
  end

  def trains(type = nil)
    if type
      @trains.select {|train| train.type == type}
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
          raise "wrong train type"
          return
      end
      print_train(type)
    else
      puts "No trains in #{self.name}"
    end
  end

  protected

  def validate!
    raise "Only letters available" if name !~ NAME_FORMAT
    raise "Name field couldn't be empty" if name.empty?
    true
  end
end
