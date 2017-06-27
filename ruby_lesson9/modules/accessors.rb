module Accessor
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      class_eval %Q{
    	def #{name}=(value)
        @#{name}_history = [] unless defined? @#{name}_history
    		@#{name} = (value)
    		@#{name}_history << @#{name}
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
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise "Argument isn't #{type} type." unless value.instance_of?(type)
        instance_variable_set(var_name, value)
      end
    end
  end
end