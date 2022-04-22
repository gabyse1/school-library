require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative '../modules/validators'
require_relative '../modules/persist_load_data'
require 'json'

class App
  def initialize
    @books = load_data_books
    @people = load_data_people
    @rentals = load_data_rentals
  end

  include Validators
  include PersistLoadData

  def person_menu
    type = 0
    while type != 1 && type != 2
      print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
      type = gets.chomp.to_i
    end
    type
  end

  def create_person
    type = person_menu
    age = valid_integer_input('Age')
    print 'Name: '
    name = gets.chomp

    if type == 1
      menu = 'Has parent permission? [Y/N]'
      person = Student.new(age, name: name) if valid_bool_input(menu) == 'y'
      person = Student.new(age, name: name, parent_permission: false) if valid_bool_input(menu) == 'n'
    else
      print 'Spetialization: '
      spetialization = gets.chomp
      person = Teacher.new(spetialization, age, name: name)
    end
    @people.push(person)
    puts 'Person created successfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @books.push(Book.new(title, author))
    puts 'Book created successfully'
  end

  def add_book_and_person
    bookidx = -1
    while bookidx < 1 || bookidx > @books.length
      puts 'Select a book from the following list by number'
      @books.each_with_index.each { |b, i| puts "#{i + 1}) Title: #{b.title}, Author: #{b.author}" }
      bookidx = gets.chomp.to_i
    end

    personidx = -1
    puts "\n"
    while personidx < 1 || personidx > @people.length
      puts 'Select a person from the following list by number (not id)'
      @people.each_with_index.each do |pe, i|
        puts "#{i + 1}) [#{pe.class}] Name: #{pe.name}, ID: #{pe.id}, Age: #{pe.age}"
      end
      personidx = gets.chomp.to_i
    end
    [personidx - 1, bookidx - 1]
  end

  def create_rental
    indexes = add_book_and_person
    date = ''
    puts "\n"
    until valid_date?(date)
      print 'Date [yyyy/mm/dd]: '
      date = gets.chomp
    end
    @rentals.push(Rental.new(date, @books[indexes[1]], @people[indexes[0]]))
    puts 'Rental created successfully'
  end

  def list_books
    puts '------ AVAILABLE BOOKS ------'
    @books.each { |b| puts "Title: #{b.title}, Author: #{b.author}" }
  end

  def list_people
    puts '------ AVAILABLE PEOPLE ------'
    puts @people
    @people.each { |pe| puts "[#{pe.class}] Name: #{pe.name}, ID: #{pe.id}, Age: #{pe.age}" }
  end

  def list_rentals
    print 'ID of person: '
    id = gets.chomp.to_i
    puts 'Rentals:'
    @rentals.each { |r| puts "Date: #{r.date}, Book \"#{r.book.title}\" by #{r.person.name}" if r.person.id == id }
  end
end
