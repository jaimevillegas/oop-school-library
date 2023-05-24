require './person'

describe Person do
  person1 = Person.new(26, "Jaime")

  it "Should create a new instance of Person" do
    expect(person1).to be_an_instance_of Person
  end

  it "Should check if the age is 26" do
    expect(person1.age).to eq 26
  end

  it "Should check if the name is Jaime" do
    expect(person1.name).to eq "Jaime"
  end

  it "Should check if the person can use services (26 == true)" do
    expect(person1.can_use_services?).to eq true
  end

  it "Should check if correct_name returns the name of the person" do
    expect(person1.correct_name).to eq person1.name
  end

  it "Should create a Rental" do
    book1 = double("book")
    allow(book1).to receive(:title) { "The Lord of the Rings" }
    allow(book1).to receive(:author) { "J. R. R. Tolkien" }
    allow(book1).to receive(:rental) { [] }

    rental1 = person1.add_rental(book1, "2021-01-01")

    expect(rental1).to be_an_instance_of Rental
  end



end