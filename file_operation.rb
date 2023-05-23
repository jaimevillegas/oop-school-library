require './person'
require './student'
require './teacher'
require './rental'
require './book'

module FileOperation
  def read_people
    people = []
    data = load_files('people.json')
    return unless File.exist?('people.json') && (File.read('people.json') != '[]')

    data['students'].each do |student|
      new_student = Student.new(student['age'], student['name'], student['id'])
      people << new_student
    end
    data['teachers'].each do |teacher|
      new_teacher = Teacher.new(teacher['age'], teacher['name'], teacher['specialization'], teacher['id'])
      people << new_teacher
    end
    people
  end

  def read_books
    books = []
    data = load_files('books.json')
    return unless File.exist?('books.json') && (File.read('books.json') != '[]')

    data.each do |book|
      new_book = Book.new(book['title'], book['author'])
      books << new_book
    end
    books
  end

  def read_rentals(persons, books)
    rentals = []
    data = load_files('rentals.json')
    return unless File.exist?('rentals.json') && (File.read('rentals.json') != '[]')

    data.each do |rental|
      person = persons.select { |item| item.id == rental['person_id'] }
      book = books.select { |item| item.title == rental['book_title'] }
      new_rental = Rental.new(rental['date'], person[0], book[0])
      rentals << new_rental
    end
    rentals
  end

  def load_files(file)
    if File.exist?(file)
      File.open(file)
    else
      File.write(file, [])
    end
    JSON.parse(File.read(file))
  end

  def save_people(persons)
    saved_people = { students: [], teachers: [] }
    persons.each do |person|
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

  def save_books(books)
    saved_books = []
    books.each do |book|
      book_hash = {}
      book_hash[:author] = book.author
      book_hash[:title] = book.title
      saved_books.push(book_hash)
    end
    File.write('./books.json', JSON.generate(saved_books))
  end

  def save_rentals(rentals)
    saved_rentals = []
    rentals.each do |rental|
      rental_hash = {}
      rental_hash[:date] = rental.date
      rental_hash[:person_id] = rental.person.id
      rental_hash[:book_title] = rental.book.title
      saved_rentals.push(rental_hash)
    end
    File.write('./rentals.json', JSON.generate(saved_rentals))
  end
end
