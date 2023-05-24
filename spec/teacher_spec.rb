require './teacher'

describe Teacher do 
  teacher = Teacher.new 12, 'David', 'Doctor'
  it "Should be an kind of person" do
    expect(teacher).to be_kind_of Person
  end 
  it "Should be an instance of teacher" do
    expect(teacher).to be_instance_of Teacher
  end 
  it "Should be able to use services" do 
    expect(teacher.can_use_services?).to be true
  end
end