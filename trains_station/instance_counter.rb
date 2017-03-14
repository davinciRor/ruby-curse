module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @@instances = 0

    def instances
      @@instances
    end

    def instances=(value)
      @@instances = value
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances += 1
    end
  end
end

class A
  include InstanceCounter

  def initialize
    self.register_instance
  end
end

A.new
A.new
puts A.instances
