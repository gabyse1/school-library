require_relative 'person'

class Teacher < Person
  attr_accessor :spetialization

  def initialize(spetialization, age, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission)
    @spetialization = spetialization
  end

  def can_use_service?
    true
  end
end
