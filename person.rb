require './nameable'
require './rental'
# Create a class person
class Person < Nameable
  # Getters and Setters
  attr_accessor :name, :age, :rental, :id

  # Constructor with 3 parameters. 2 of them default
  def initialize(age, name = 'Unknown', id = Random.rand(1..100), parent_permission: true)
    super()
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rental = []
  end

  # Returns true if person is of age or if they have permission from parents
  def can_use_services?
    return true if of_age? || @parent_permission

    false
  end

  def correct_name
    @name
  end

  def add_rental(book, date)
    Rental.new(date, book, self)
  end

  # Private methods
  private

  # Returns true if @age >= 18
  def of_age?
    return true if @age >= 18

    false
  end
end
