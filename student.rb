require './person'

# Class Student that inherits from Person
class Student < Person
  attr_accessor :classroom

  # Constructor that extends parent's constructor by adding @classroom and a parameter for it
  def initialize(age, name, parent_permission)
    super(age, name, parent_permission: parent_permission)
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.student.push(self) unless classroom.students.include?(self)
  end

  # Method that returns a string
  def play_hooky
    '¯\(ツ)/¯'
  end
end
