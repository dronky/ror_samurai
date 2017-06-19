module Acessors
  def attr_accessor_with_history(*names)
    $history = {}
    names.each do |name|
      var_name = "@#{name}".to_sym
      $history[var_name]=[]
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        $history[var_name]=value
      end
      define_method("#{name}_history".to_sym) { puts $history["#{name}".to_sym] }
    end
  end
end

class Test
  extend Acessors
  attr_accessor_with_history :memes, :speak
end

m = Test.new
m.speak=2
puts m.speak