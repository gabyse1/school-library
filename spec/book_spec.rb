require_relative '../classes/book'
require 'json'

describe Book do
  before :all do
    @books_arr = [Book.new('JavaScript', 'Douglas Crockfour'), Book.new('Ruby', 'Jeffrey Zeldman')]

    bookstemp = []
    @books_arr.each do |book|
      bookstemp << { title: book.title, author: book.author }
    end
    File.write('spec/books.json', bookstemp.to_json)
  end

  before :each do
    @books = []
    if File.exist?('spec/books.json')
      bookstemp = JSON.parse(File.read('spec/books.json'))
      bookstemp.each do |book|
        @books << Book.new(book['title'], book['author'])
      end
    end
  end

  context '#load_data method' do
    it 'should has 2 Books' do
      expect(@books.length).to eql 2
    end
  end

  describe '#new method' do
    context 'with no parameters' do
      it 'throws an argument error' do
        expect { Book.new }.to raise_exception ArgumentError
      end
    end

    context 'with two parameters' do
      it 'is an instance of the Book class' do
        expect(Book.new('title', 'author')).to be_an_instance_of Book
      end
    end
  end

  describe '#Get' do
    context 'book title' do
      it 'returns the correct book title' do
        expect(@books_arr[0].title).to eql 'JavaScript'
      end
    end

    context 'book author' do
      it 'returns the correct book author' do
        expect(@books_arr[1].author).to eql 'Jeffrey Zeldman'
      end
    end
  end
end
