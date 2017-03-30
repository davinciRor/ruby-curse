module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(attribute_name, validation_type, option = true)
      if validates_hash[attribute_name]
        validates_hash[attribute_name][validation_type] = {
          option: option,
          error_message: validation_errors(validation_type, attribute_name)
        }
      else
        validates_hash[attribute_name] = {
          validation_type => {
            option: option,
            error_message: validation_errors(validation_type, attribute_name)
          }
        }
      end
    end

    def validates_hash
      @validates_hash ||= {}
    end

    private

    def validation_errors(type, attr_name)
      case type
      when :presence
        "#{attr_name} can`t be nil or ''"
      when :format
        "#{attr_name} has invalid format"
      when :type
        "#{attr_name} has invalid type"
      end
    end

    def validation_types
      [:presence, :format, :type]
    end
  end

  module InstanceMethods
    def validate!
      self.class.validates_hash.each do |attr_name, value|
        value.each do |key, value|
          self.send("#{key}_validation", value[:error_message], attr_name, value[:option])
        end
      end
      true
    end

    def valid?
      validate!
    rescue
      false
    end

    protected

    def presence_validation(error_message, attr_name, option = true)
      raise error_message if [nil, ''].include?(self.public_send(attr_name))
    end

    def format_validation(error_message, attr_name, option)
      raise error_message if self.public_send(attr_name) !~ option
    end

    def type_validation(error_message, attr_name, option)
      raise error_message unless self.public_send(attr_name).is_a? option
    end
  end
end


class A
  include Validation

  attr_accessor :name

  validate :name, :presence
  validate :name, :format, /[A-Z]{0,3}/i
  validate :name, :type, String

  def initialize(name)
    @name = name
  end
end
