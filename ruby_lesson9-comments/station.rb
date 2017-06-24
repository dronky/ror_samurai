require_relative 'module_instance_counter'
require_relative 'valid_module'
require_relative 'module_validation'

class Station
  include InstanceCounter
  include Valid
  extend Validation

  attr_reader :name
  attr_accessor :trains
  validate :name, :presence

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

  def each(&block)
    trains.each(&block)
  end

  def del_train(train)
    trains.delete(train)
  end

  def trains(type = nil)
    if type
      @trains.select { |train| train.type == type }
    else
      @trains
    end
  end

  def to_s
    "Station: #{name}"
  end

  def depart
    trains.first.depart(:forward)
  end

  def print_train(type = nil)
    trains(type).each_with_index do |train, i|
      puts "Train #{i + 1}: "
      puts train
    end
  end

  def print_trains(type = nil)
    puts "\n#{name} trains:"
    if !trains.empty?
      case type
      when nil
        puts "Gruz trains: #{trains('gruz').size} Pass trains: #{trains('pass').size}"
      when 'gruz'
        puts "Gruz trains: #{trains('gruz').size}"
      when 'pass'
        puts "Pass trains: #{trains('pass').size}"
      else
        raise 'wrong train type'
      end
      print_train(type)
    else
      puts "No trains in #{name}"
    end
  end
end
