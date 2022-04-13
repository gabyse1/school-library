require_relative 'nameable'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission: true, **options)
    super(**options)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_service?
    id_of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  private

  def id_of_age?
    @age >= 18
  end
end
