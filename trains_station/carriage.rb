require_relative 'company'
require 'pry'

# Describe Carriage
class Carriage
  include Company
  include Validation

  validate :company_name, :presence

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
end
