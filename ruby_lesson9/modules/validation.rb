module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    attr_accessor :valid_list

    def validate(atr_name, valid_type, params = nil)
      @valid_list ||= []
      @valid_list.push(atr_name: atr_name, valid_type: valid_type, params: params)
    end
  end

  module InstanceMethods

    def validate!
      self.class.valid_list.each do |validation|
        value = instance_variable_get("@#{validation[:atr_name]}")
        method_name = validation[:valid_type]
        if method(method_name).arity > 1
          send(method_name, value, validation[:params])
        else
          send(method_name, value)
        end
      end
    end

    def valid?
      begin
        validate!
        true
      rescue
        false
      end
    end

    private

    def presence(value)
      raise "Argument couldn't be nil" if value.nil? || value.empty?
    end

    def format(value, params)
      if params.match(value)
        true
      else
        raise "#{value} not match regex"
      end
    end

    def type(value, params)
      if value.instance_of?(params)
        true
      else
        raise "#{value} not match #{params}"
      end
    end
  end
end

class Test
  include Validation
  attr_accessor :paresence_var, :fmt_var, :class_val
  validate :presence_var, :presence
  validate :fmt_var, :format, /^[a-z0-9]{3}-?[a-z0-9]{2}$/i
  validate :class_val, :type, Integer

  def initialize(pre, fmt, class_val)
    @pre = pre
    @fmt_var = fmt
    @class_val = class_val
    validate!
  end
end

# a = Test.new('8', 'aaa-11',22)