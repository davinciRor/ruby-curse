module Accessor
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*methods)
      methods.each do |method|
        raise TypeError.new("method name  is not symbol") unless method.is_a?(Symbol)
        var_name = "@#{method}"
        var_name_history = "@#{method}_history"

        define_method(method) do
          instance_variable_get(var_name)
        end

        define_method("#{method}=") do |value|
          instance_variable_set(var_name, value)
          self.send("#{method}_history") << value
        end

        define_method("#{method}_history") do
          instance_variable_get(var_name_history) ||
          instance_variable_set(var_name_history, [])
        end
      end
    end

    def strong_attr_accessor(method, klass)
      raise TypeError.new("method name  is not symbol") unless method.is_a?(Symbol)
      var_name = "@#{method}"

      define_method(method) do
        instance_variable_get(var_name)
      end

      define_method("#{method}=") do |value|
        raise TypeError.new("value is not #{klass}") unless value.is_a?(klass)
        instance_variable_set(var_name, value)
      end
    end
  end
end

class A
  include Accessor
  attr_accessor_with_history :name, :age
  strong_attr_accessor :level, Fixnum
end
