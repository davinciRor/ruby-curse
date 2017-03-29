module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(attribute_name, validation_type, option = true)
      if validates_hash[attribute_name]
        if validates_hash[attribute_name][validation_type]
          puts "Worning!!! You use same validation"
        else
          validates_hash[attribute_name][validation_type] = {
            option: option,
            error_message: validation_errors(validation_type, attribute_name)
          }
        end
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
          case key
          when :presence
            raise value[:error_message] if [nil, ''].include?(self.public_send(attr_name))
          when :format
            raise value[:error_message] if self.public_send(attr_name) !~ value[:option]
          when :type
            raise value[:error_message] unless self.public_send(attr_name).is_a? value[:option]
          end
        end
      end
      true
    end

    def valid?
      validate!
    rescue
      false
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
