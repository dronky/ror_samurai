module Validation
  def validate(atr_name, valid_type, params = nil)
    case valid_type
      when :presence
        define_method(:validate!) {raise "#{instance_variable_get("@#{atr_name}")} couldn't be nil" if instance_variable_get("@#{atr_name}").nil? || instance_variable_get("@#{atr_name}").empty?}
      when :format
        define_method(:validate!) {raise "#{instance_variable_get("@#{atr_name}")} not match regex" unless params.match(instance_variable_get("@#{atr_name}"))}
      when :type
        define_method(:validate!) {raise "#{instance_variable_get("@#{atr_name}")} not match @#{params}" unless instance_variable_get("@#{atr_name}").instance_of?(params)}
    end
  end
end

# class Test
#   extend Validation
#
#   attr_accessor :a, :b, :c
#   validate :a, :presence
#   validate :b, :format, /^[a-z]{0,3}$/
#   validate :c, :type, String
#   def initialize(a,b,c)
#     @a=a
#     @b=b
#     @c=c
#     validate!
#   end
# end
#
# lol = Test.new('asd','a', 123)
# puts lol.a