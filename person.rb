# frozen_string_literal: true

# Create a class person
class Person
  # Getters and Setters
  attr_accessor :name, :age
  attr_reader :id

  # Constructor with 3 parameters. 2 of them default
  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..100)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  # Returns true if person is of age or if they have permission from parents
  def can_use_services?
    return true if of_age? || @parent_permission

    false
  end

  # Private methods
  private

  # Returns true if @age >= 18
  def of_age?
    return true if @age >= 18

    false
  end
end
