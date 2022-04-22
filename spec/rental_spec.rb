require_relative '../classes/rental'
require_relative '../classes/book'
require_relative '../classes/person'
require_relative '../classes/student'
require_relative '../classes/teacher'
require 'json'

describe Rental do
  before :all do
    book1 = Book.new('JavaScript', 'Douglas Crockfour')
    book2 = Book.new('Ruby', 'Jeffrey Zeldman')
    person1 = Student.new(20, name: 'Fabrizio Y.')
    person2 = Teacher.new('React', 25, name: 'Andrés M.')

    @books_arr = [book1, book2]
    @people_arr = [person1, person2]

    @rentals_arr = [
      Rental.new('2022/04/15', book1, person1),
      Rental.new('2022/04/16', book2, person1),
      Rental.new('2022/04/17', book2, person2)
    ]

    rentaltemp = []
    @rentals_arr.each do |rental|
      rentaltemp << { date: rental.date, book: rental.book.title, person: rental.person.id }
    end
    File.write('spec/rentals.json', rentaltemp.to_json)
  end

  before :each do
    @rentals = []
    if File.exist?('spec/rentals.json')
      @rentals_array = JSON.parse(File.read('spec/rentals.json'))
      @rentals_array.each do |obj|
        person_obj = @people_arr.find { |person| person.id == obj['person'] }
        book_obj = @books_arr.find { |book| book.title == obj['book'] }
        @rentals << Rental.new(obj['date'], book_obj, person_obj)
      end
    end
  end

  describe '#load_data' do
    context 'from a json file' do
      it 'should has three rentals' do
        expect(@rentals.length).to eql 3
      end
    end
  end

  describe '#new' do
    context 'with no parameters' do
      it 'should throw an Argument Error' do
        expect { Rental.new }.to raise_exception ArgumentError
      end
    end

    context 'with parameters' do
      it 'should be an instance of rental class' do
        expect(@rentals_arr[0]).to be_an_instance_of Rental
      end
    end
  end

  describe '#Get' do
    context 'Date' do
      it 'should return the correct date for the first rental' do
        expect(@rentals[0].date).to eql '2022/04/15'
      end
    end

    context 'Book' do
      it 'should return the correct book title for the second rental' do
        expect(@rentals[1].book.title).to eql 'Ruby'
      end
    end

    context 'Person' do
      it 'should return the correct person name for the third rental' do
        expect(@rentals[2].person.name).to eql 'Andrés M.'
      end
    end
  end
end
