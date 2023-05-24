require './rental'

describe Rental do
  
  it "Should create a new instance of Rental and verify the date" do
    person1 = double("person")
    allow(person1).to receive(:age) { 26 }
    allow(person1).to receive(:name) { "Jaime" }
    allow(person1).to receive(:rental) { [] }
    
    book1 = double("book")
    allow(book1).to receive(:title) { "The Lord of the Rings" }
    allow(book1).to receive(:author) { "J. R. R. Tolkien" }
    allow(book1).to receive(:rental) { [] }
    
    rental1 = Rental.new("2021-01-01", person1, book1)
    expect(rental1).to be_an_instance_of Rental
    expect(rental1.date).to eq("2021-01-01")
  end

end