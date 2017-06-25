module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    attr_accessor :valid_list

    def validate(atr_name, valid_type, params = nil)
      @valid_list = []
      case valid_type
        when :presence
          @valid_list << {attr_name: atr_name, valid_type: 'validate_presence', params: params}
        when :format
          @valid_list << {attr_name: atr_name, valid_type: 'validate_format', params: params}
        when :type
          @valid_list << {attr_name: atr_name, valid_type: 'validate_type', params: params}
      end
    end
  end

  module InstanceMethods

    def validate!
      self.class.valid_list.each { |validation|
        value = instance_variable_get("@#{validation[:attr_name]}")
        self.send validation[:valid_type].to_sym, value, validation[:params]
      }
    end

    def valid?
      if validate!
        true
      else
        false
      end
    end

    private

    def validate_presence(value)
      if value.nil? || value.empty?
        raise "Argument couldn't be nil"
      else
        true
      end
    end

    def validate_format(value, params = nil)
      if params.match(value)
        true
      else
        raise "#{value} not match regex"
      end
    end

    def validate_type(value, params = nil)
      if value.instance_of?(params)
        true
      else
        raise "#{value} not match @#{params}"
      end
    end
  end
end

class Test
  include Validation
  attr_accessor :paresence_var, :fmt_var, :class_val
  validate :presence_var, :presence
  validate :fmt_var, :format, /^[a-z0-9]{3}-?[a-z0-9]{2}$/i
  validate :class_val, :type, Fixnum

  def initialize(pre, fmt, class_val)
    @pre = pre
    @fmt_var = fmt
    @class_val = class_val
    validate!
  end
end

# a = Test.new('8', 'aaa-11',22)