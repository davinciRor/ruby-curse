require 'pry'

# Module for count instance of class
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # Module for class methods
  module ClassMethods
    attr_accessor :instances
  end

  # Module for instance methods
  module InstanceMethods
    protected

    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end
