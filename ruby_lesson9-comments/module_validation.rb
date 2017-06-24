module Validation
  def validate(atr_name, valid_type, params = nil)
    case valid_type
      when :presence
        define_method(:validate!) {raise "#{instance_variable_get("@#{atr_name}")} couldn't be nil" if instance_variable_get("@#{atr_name}").nil? || instance_variable_get("@#{atr_name}").empty?; true}
      when :format
        define_method(:validate!) {raise "#{instance_variable_get("@#{atr_name}")} not match regex" unless params.match(instance_variable_get("@#{atr_name}")); true}
      when :type
        define_method(:validate!) {raise "#{instance_variable_get("@#{atr_name}")} not match @#{params}" unless instance_variable_get("@#{atr_name}").instance_of?(params); true}
    end
  end
end
