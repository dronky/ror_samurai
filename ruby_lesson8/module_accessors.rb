# module Acessors
#     def self.included(base)
#       base.extend(ClassMethods)
#       base.include(InstanceMethoods)
#     end

#     def ClassMethods
#       def attr_accessor_with_history(*names)
#         names.each do |name|
#           var_name = "@#{name}".to_sym
#           @history[name.to_sym]=[]
#           define_method(name) { instance_variable_get(var_name) }
#           define_method("#{name}=".to_sym) do |value|
#             instance_variable_set(var_name, value)
#             @history[name.to_sym]<<value
#           end
#           define_method("#{name}_history".to_sym) { puts @history[name.to_sym] }
#         end
#       end
#     end
    
#     def InstanceMethods
#       def history
#         @history||={}
#       end
#       def register_instance
#         self.class.send :add_instance
#       end
#     end
# end

#   class Test
#     include Acessors
#     attr_accessor_with_history :memes, :speak
#   end

#   m = Test.new
#   m.speak=2
#   m.speak=4
#   m.speak=1290441
#   m.speak_history

module Acessors
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
      def attr_accessor_with_history(*names)
        names.each do |name|
          var_name = "@#{name}".to_sym
          @history[name.to_sym]=[]
          define_method(name) { instance_variable_get(var_name) }
          define_method("#{name}=".to_sym) do |value|
            instance_variable_set(var_name, value)
            @history[name.to_sym]<<value
          end
          define_method("#{name}_history".to_sym) { puts @history[name.to_sym] }
        end
      end
  end

  module InstanceMethods
    def history
      @history||={}
    end

    protected
    def register_instance
      self.class.send :add_instance
    end
  end
end

class Test
  include Acessors
  attr_accessor_with_history :memes, :speak
  attr_accessor :history
  def initialize
    @history={}
  end
end

m=Test.new
