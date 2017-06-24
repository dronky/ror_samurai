module Accessor
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) {instance_variable_get(var_name)}

      class_eval %Q{
    	def #{name}=(value)
    		@#{name}_history = [@#{name}] unless defined? @#{name}_history
    		@#{name} = (value)
    		@#{name}_history << @#{name} unless !defined? @#{name}_history
    	end

      def #{name}_history
        @#{name}_history
      end
	    }
    end

  end

  def strong_attr_accessor (*args, type)
    args.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) {instance_variable_get(var_name)}
      define_method("#{name}=".to_sym) do |value|
        raise "Argument isn't #{type} type." unless value.instance_of?(type)
        instance_variable_set(var_name, value) if value.instance_of?(type)
      end
    end

  end
end

class Test
  extend Accessor
  # почему здесь использется extend, если мы обращаемся к инстансам класса, а не к классу?
  attr_accessor_with_history :a, :b, :c
  strong_attr_accessor :lol, :memes, String
end

d = Test.new
d.a = 7
d.a = 6
d.a = 8
p d.a_history

kk = Test.new
puts kk.memes = "123"
puts kk.lol = 123