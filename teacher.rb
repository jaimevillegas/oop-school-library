require './person'

# Class Teacher that inherits from Person
class Teacher < Person
  attr_accessor :specialization

  # Constructor that extends parent's constructor by adding @specialization and a parameter
  def initialize(age, name, specialization, parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  # Always return true. Override parent's method
  def can_use_services?
    true
  end
end
