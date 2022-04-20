require_relative 'person'

class Teacher < Person
  attr_accessor :spetialization

  def initialize(spetialization:, **options)
    super(**options)
    @spetialization = spetialization
  end

  def can_use_service?
    true
  end
end
