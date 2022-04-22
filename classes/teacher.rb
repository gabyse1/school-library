require_relative 'person'

class Teacher < Person
  attr_accessor :spetialization

  def initialize(spetialization, age, id: Random.rand(1..1000), name: 'Unknown', parent_permission: true)
    super(age, id: id, name: name, parent_permission: parent_permission)
    @spetialization = spetialization
  end

  def can_use_service?
    true
  end
end
