module InstanceCounter

  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethoods)
  end

  module ClassMethods
    @instances = 0

    def instances
      @instances
    end

    protected

    def add_instance
      @instances ||= 0
      @instances += 1
    end
  end

  module InstanceMethoods

    protected

    def register_instance
      self.class.send :add_instance
    end
  end
end