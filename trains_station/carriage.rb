require_relative 'company'
require 'pry'

class Carriage
  include Company

  def initialize(company_name)
    @company_name = company_name
    validate!
  end

  def type
    raise NotImplementedError, 'Sorry you need override type'
  end

  def info
    raise NotImplementedError, 'Sorry you need override info'
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Company Name can`t be nil" if company_name.nil?
  end
end
