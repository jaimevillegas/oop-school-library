# frozen_string_literal: true

require './person'

# Class Teacher that inherits from Person
class Teacher < Person
  # Constructor that extends parent's constructor by adding @specialization and a parameter
  def initialize(age, specialization, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  # Always return true. Override parent's method
  def can_use_services?
    true
  end
end
