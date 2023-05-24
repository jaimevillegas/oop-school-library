require './book'

describe Book do
    book1 = Book.new("The Lord of the Rings", "J. R. R. Tolkien")

  it "Should create a new instance of Book" do
    expect(book1).to be_an_instance_of Book
  end

  it "Should check if the title is correct" do
    expect(book1.title).to eq("The Lord of the Rings")
  end

  it "Should check if the author is correct" do
    expect(book1.author).to eq("J. R. R. Tolkien")
  end

  it "Should create a Rental" do
    person1 = double("person")
    allow(person1).to receive(:age) { 26 }
    allow(person1).to receive(:name) { "Jaime" }
    allow(person1).to receive(:rental) { [] }

    rental1 = book1.add_rental(person1, "2021-01-01")

    expect(rental1).to be_an_instance_of Rental
  end
end