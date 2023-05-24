require './classroom'

describe Classroom do
  classroom1 = Classroom.new('Classroom 1')

  it 'Should create a new instance of Classroom' do
    expect(classroom1).to be_an_instance_of Classroom
  end

  it 'Should check if the label is correct' do
    expect(classroom1.label).to eq('Classroom 1')
  end

  it 'Should add a student' do
    student1 = double('student')
    allow(student1).to receive(:age) { 26 }
    allow(student1).to receive(:name) { 'Jaime' }
    allow(student1).to receive(:classroom) { [] }

    classroom1.add_student(student1)

    expect(classroom1.students).to be_an_instance_of Array
    expect(classroom1.students).to include(student1)
  end
end
