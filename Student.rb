# frozen_string_literal: true

require './person'

# Class Student that inherits from Person
class Student < Person
  # Constructor that extends parent's constructor by adding @classroom and a parameter for it
  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  # Method that returns a string
  def play_hooky
    '¯\(ツ)/¯'
  end
end
