require_relative '../decorators/nameable'

class Person < Nameable
  attr_accessor :age, :id, :name, :parent_permission
  attr_reader :rentals

  def initialize(age:, id: Random.rand(1..1000), name: 'Unknown', parent_permission: true, **options)
    super(**options)
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
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
