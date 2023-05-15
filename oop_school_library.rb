require './person'
require './student'
require './teacher'

# This file is for testing purposes

person1 = Person.new(26, 'Jaime', true)
puts person1.can_use_services?

person2 = Student.new(16, 'web programming', 'andres', false)
puts person2.play_hooky

person3 = Teacher.new(40, 'Multiverse Theory', 'Bruce Wayne')
puts person3.can_use_services?
