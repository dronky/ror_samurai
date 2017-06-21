# module Acessors
#   def attr_accessor_with_history(*names)
#     $history = {}
#     names.each do |name|
#       var_name = "@#{name}".to_sym
#       $history[name.to_sym]=[]
#       define_method(name) { instance_variable_get(var_name) }
#       define_method("#{name}=".to_sym) do |value|
#         instance_variable_set(var_name, value)
#         $history[name.to_sym]<<value
#       end
#       define_method("#{name}_history".to_sym) { puts $history[name.to_sym] }
#     end
#   end
# end
#
# class Test
#   extend Acessors
#   attr_accessor_with_history :memes, :speak
# end
#
# m = Test.new
# m.speak=2
# m.speak=4
# m.speak=1290441
# m.speak_history

#http://webcache.googleusercontent.com/search?q=cache:Kxs5JptNARcJ:www.richardshin.com/attr_accessor_with_history/&num=1&hl=ru&gl=ru&strip=1&vwsrc=0
#https://github.com/wmora/cs169.1x/blob/master/hw1/part5.rb

module Accessor
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) {instance_variable_get(var_name)}
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(:@list_values, [])
        instance_variable_set(var_name, value)
      end
      # define_method("#{name}_history=".to_sym) do |value|
      #   %Q"
      #     @#{name}_history = [] if @#{name}_history.nil?
      #     @#{name}_history << @#{name}
      #     @#{name}_history
      #   "
      # end
      #   class_eval %Q"
      #     def #{name}_history
      #       @#{name}_history = [] if @#{name}_history.nil?
      #       @#{name}_history << @#{name}
      #       puts @#{name}_history.size
      #     end
      # "
      #
      #   class_eval do
      #     def history(names)
      #       instance_variable_get("@#{name}_history")
      #     end
      #   end
      # end

    end
  end
end

class Test
  extend Accessor

  attr_accessor_with_history :a, :b, :c
end

d = Test.new
d.a = 7
d.a = 6
d.a = 8
puts d.instance_variable_get(:@list_values)