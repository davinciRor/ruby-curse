require 'pry'

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end

class A
  include InstanceCounter

  def initialize
    register_instance
  end
end

class B
  include InstanceCounter

  def initialize
    self.register_instance
  end
end

A.new
A.new
B.new
puts B.instances
puts A.instances
