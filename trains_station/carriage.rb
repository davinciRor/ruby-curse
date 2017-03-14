require_relative 'company'

class Carriage
  include Company
  
  def type
    raise NotImplementedError, 'Sorry you need override type'
  end
end
