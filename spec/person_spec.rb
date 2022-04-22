require_relative '../classes/person'
require_relative '../classes/student'
require_relative '../classes/teacher'
require 'json'

describe Person do
  before :all do
    @people_arr = [Student.new(20, name: 'Fabrizio Y.'), Teacher.new('React', 25, name: 'Andrés M.')]

    peopletemp = []
    @people_arr.each do |person|
      person_obj = {
        id: person.id,
        age: person.age,
        name: person.name,
        parent_permission: person.parent_permission
      }
      person_obj['spetialization'] = person.spetialization if person.instance_of? Teacher
      peopletemp << person_obj
    end
    File.write('spec/people.json', peopletemp.to_json)
  end

  before :each do
    @people = []
    if File.exist?('spec/people.json')
      peopletemp = JSON.parse(File.read('spec/people.json'))
      peopletemp.each do |pe|
        @people <<
          if pe['spetialization']
            Teacher.new(
              pe['spetialization'],
              pe['age'],
              id: pe['id'],
              name: pe['name']
            )
          else
            Student.new(
              pe['age'],
              id: pe['id'],
              name: pe['name'],
              parent_permission: pe['parent_permission']
            )
          end
      end
    end
  end

  context '#load_data method' do
    it 'should has 2 people' do
      expect(@people.length).to eql 2
    end
  end

  describe '#Person new method' do
    context 'with no parameters' do
      it 'throws an argument error' do
        expect { Person.new }.to raise_exception ArgumentError
      end
    end

    context 'with almost one parameter' do
      it 'is an instance of the Person class' do
        expect(Person.new(20)).to be_an_instance_of Person
      end
    end
  end

  describe '#Student new method' do
    context 'with no parameters' do
      it 'throws an argument error' do
        expect { Student.new }.to raise_exception ArgumentError
      end
    end

    context 'with almost one parameter' do
      it 'is an instance of the Person class' do
        expect(Student.new(20, name: 'Gabriela')).to be_an_instance_of Student
      end
    end
  end

  describe '#Teacher new method' do
    context 'with no parameters' do
      it 'throws an argument error' do
        expect { Teacher.new }.to raise_exception ArgumentError
      end
    end

    context 'with almost one parameter' do
      it 'is an instance of the Person class' do
        expect(Teacher.new('teacher', 30, name: 'Gabriela')).to be_an_instance_of Teacher
      end
    end
  end

  describe '#Get' do
    context 'student name' do
      it 'returns the correct student name' do
        expect(@people[0].name).to eql 'Fabrizio Y.'
      end
    end

    context 'book author' do
      it 'returns the correct teacher spetalization' do
        expect(@people[1].spetialization).to eql 'React'
      end
    end
  end
end
