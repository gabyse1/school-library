require_relative 'nameable'

class Decorator < Nameable
  def initialize(nameable, **options)
    super(**options)
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end
