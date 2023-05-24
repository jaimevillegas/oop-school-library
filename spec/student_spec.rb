require './student'
require './person'
describe Student do 
  student = Student.new 12, 'David'
  it "Should be an kind of person" do
    expect(student).to be_kind_of Person
  end 
  it "Should be an instance of student" do
    expect(student).to be_instance_of Student
  end 

  it "Should play hooky" do
    expect(student.play_hooky).to eq '¯\(ツ)/¯'
  end
end