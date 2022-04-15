require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def display_menu
    puts "\n\nPlease choose an option by entering a number:"
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end

  def valid_integer_input(request)
    input = -1
    while input <= 0
      print "#{request}: "
      input = gets.chomp.to_i
    end
    input
  end

  def valid_boolean_input(request)
    input = ''
    while input.downcase != 'y' && input.downcase != 'n'
      print "#{request}: "
      input = gets.chomp
    end
    input
  end

  def leap_year?(year)
    return true if (year % 400).zero?
    return false if (year % 100).zero?
    return true if (year % 4).zero?
  end

  def valid_date_day?(day, month, year)
    answer = false
    if month == 2
      answer = day <= 29 if leap_year?(year)
      answer = day <= 28 unless leap_year?(year)
    elsif [4, 6, 9, 11].include?(month)
      answer = day <= 30
    else
      answer = day <= 31
    end
    answer
  end

  def valid_date?(date)
    tempdate = date.split(%r{/}, 3)
    date_y = tempdate[0].to_i
    date_m = tempdate[1].to_i
    date_d = tempdate[2].to_i
    year = date_y > 1900
    month = date_m >= 1 && date_m <= 12 if year
    preday = date_d >= 1 if month
    day = valid_date_day?(date_d, date_m, date_y) if preday
    day
  end

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
      parent_permission = false if valid_boolean_input('Has parent permission? [Y/N]') == 'n'
      person = Student.new(age: age, name: name, parent_permission: parent_permission)
    else
      print 'Spetialization: '
      spetialization = gets.chomp
      person = Teacher.new(spetialization: spetialization, age: age, name: name)
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
    @rentals.push(Rental.new(date, @people[indexes[0]], @books[indexes[1]]))
    puts 'Rental created successfully'
  end

  def list_books
    puts '------ AVAILABLE BOOKS ------'
    @books.each { |b| puts "Title: #{b.title}, Author: #{b.author}" }
  end

  def list_people
    puts '------ AVAILABLE PEOPLE ------'
    @people.each { |pe| puts "[#{pe.class}] Name: #{pe.name}, ID: #{pe.id}, Age: #{pe.age}" }
  end

  def list_rentals
    print 'ID of person: '
    id = gets.chomp.to_i
    puts 'Rentals:'
    @rentals.each { |r| puts "Date: #{r.date}, Book \"#{r.book.title}\" by #{r.person.name}" if r.person.id == id }
  end
end
