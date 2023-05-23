require './person'
require './student'
require './teacher'
require './rental'
require './book'
require './classroom'
require 'json'
require 'pry'

class App
  def initialize
    #importedBooks = load_files('books.json')
    @persons = []
    @rentals = []
    @books = []
    get_people
    get_books
    get_rentals
  end

  def get_people
    data = load_files('people.json')
    if (File.exist?('people.json') && (File.read('people.json') != '[]'))
      data["students"].each do |student|
        newStudent = Student.new(student["age"], student["name"], student["id"])
        @persons << newStudent
      end

      data["teachers"].each do |teacher|
        newTeacher = Teacher.new(teacher["age"], teacher["name"], teacher["specialization"], teacher["id"])
        @persons << newTeacher
      end
    end
  end

  def get_books
    data = load_files('books.json')
    if (File.exist?('books.json') && (File.read('books.json') != '[]'))
      data.each do |book|
        newBook = Book.new(book["title"], book["author"])
        @books << newBook
      end
    end
  end

  def get_rentals
    data = load_files('rentals.json')
    # binding.pry
    if (File.exist?('rentals.json') && (File.read('rentals.json') != '[]'))
      data.each do |rental|
        person = @persons.select {|person| person.id == rental["person_id"]}
        book = @books.select {|book| book.title == rental["book_title"]}
        newRental = Rental.new(rental["date"], person[0], book[0])
        @rentals << newRental
      end
    end
  end

  def load_files(file)
    if (File.exist?(file))
      File.open(file)
    else
      File.open(file, 'w') { |f| f.write([])}
    end

    fileParsed = JSON.parse(File.read(file))
  end

  def welcome
    puts 'Welcome to School Library App!'
    until list_of_options
      input = gets.chomp.to_i
      if input == 7
        save_people
        save_books
        save_rentals
        puts 'Thanks for using School Library App!'
        exit
      end

      option input
    end
  end

  def list_all_books
    puts 'Database is empty. Please add a book' if @books.empty?
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_all_persons
    puts 'Database is empty. Please add a person' if @persons.empty?
    @persons.each do |person|
      puts "Name: #{person.name}, Age: #{person.age}"
    end
  end

  def create_person
    puts 'Do you want to create a student or a teacher?'
    puts '1. Student'
    puts '2. Teacher'
    input = gets.chomp.to_i
    if input == 1
      create_student
    elsif input == 2
      create_teacher
    else
      puts 'Invalid option. Please try again'
    end
  end

  def create_student
    puts 'Creating a student'
    puts 'Age?'
    age = gets.chomp.to_i
    puts 'Name?'
    name = gets.chomp
    puts 'Has parent permission? [Y/N]'
    parent_permission = gets.chomp.downcase
    case parent_permission
    when 'y'
      student = Student.new(age, name, parent_permission: true)
      @persons << student
    when 'n'
      student = Student.new(age, name, parent_permission: false)
      @persons << student
    else
      puts 'Invalid option. Please try again'
      create_student
    end
  end

  def create_teacher
    puts 'Creating a teacher'
    puts 'Age?'
    age = gets.chomp.to_i
    puts 'Name?'
    name = gets.chomp
    puts 'Specialization?'
    specialization = gets.chomp
    teacher = Teacher.new(age, name, specialization)
    @persons << teacher
    puts "Teacher created successfully with ID #{teacher.id}"
  end

  def create_book
    puts 'Creating a book'
    puts 'Title?'
    title = gets.chomp
    puts 'Author?'
    author = gets.chomp
    book = Book.new(title, author)
    @books.push(book)
    puts "Book #{title} created successfully"
  end

  def create_rental
    puts 'Select wich book you want to rent by its ID'
    @books.each_with_index { |book, index| puts "#{index}. Title: #{book.title}, Author: #{book.author}" }

    book_id = gets.chomp.to_i

    puts 'Select wich person will rent the book by its ID'
    @persons.each_with_index { |person, index| puts "#{index}. Name: #{person.name}, Age: #{person.age}" }

    person_id = gets.chomp.to_i

    puts 'Date?'
    date = gets.chomp.to_s

    rental = Rental.new(date, @persons[person_id], @books[book_id])
    @rentals << rental

    puts 'Rental created successfully'
  end

  def list_all_rentals
    puts 'Database is empty. Please add a rental' if @rentals.empty?
    puts 'Enter the ID of the rental you want to see'
    @persons.each { |person| puts "ID: #{person.id}, Name: #{person.name}" }

    id = gets.chomp.to_i
    puts 'Rented books:'
    @rentals.each do |rental|
      if rental.person.id == id
        print "Person: #{rental.person.name} Date: #{rental.date} "
        puts "Book: #{rental.book.title}, Author: #{rental.book.author}"
      else
        puts 'No rentals found'
      end
    end
  end

  private

  def save_people
    saved_people = {
      "students": [], 
      "teachers": []
    }
    @persons.each do |person|
      if person.is_a?(Student)
        student = {}
        student[:name] = person.name 
        student[:age] = person.age 
        student[:id] = person.id
        saved_people[:students].push(student)
      elsif person.is_a?(Teacher)
        teacher = {}
        teacher[:name] = person.name 
        teacher[:age] = person.age 
        teacher[:specialization] = person.specialization 
        teacher[:id] = person.id
        saved_people[:teachers].push(teacher)
      end
    end
    File.write('./people.json', JSON.generate(saved_people))
  end

  def save_books
    saved_books = []
    @books.each do |book|
      bookHash = {}
      bookHash[:author] = book.author
      bookHash[:title] = book.title
      saved_books.push(bookHash)
    end
    File.write('./books.json', JSON.generate(saved_books))
  end


  def save_rentals
    saved_rentals = []
    @rentals.each do |rental|
      rentalHash = {}
      rentalHash[:date] = rental.date
      rentalHash[:person_id] = rental.person.id
      rentalHash[:book_title] = rental.book.title
      saved_rentals.push(rentalHash)
    end
    File.write('./rentals.json', JSON.generate(saved_rentals))
  end



end
