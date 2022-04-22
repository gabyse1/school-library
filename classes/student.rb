require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(age, classroom: 'Unknown', id: Random.rand(1..1000), name: 'Unknown', parent_permission: true)
    super(age, id: id, name: name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    "¯\(ツ)/¯"
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
