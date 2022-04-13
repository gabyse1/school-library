require_relative 'person'
require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'
require_relative 'book'
require_relative 'rental'

person1 = Person.new(22, 'maximilianus')
person2 = Person.new(30, 'gaby')

book1 = Book.new('The lord of the rings', 'Tolkien')
book2 = Book.new('The old and the sea', 'Ernest Hemmingway')

rental1 = Rental.new('2022-02-10', person1, book1)
rental2 = Rental.new('2022-04-13', person1, book2)
rental3 = Rental.new('2022-03-13', person2, book2)

puts '------ PERSONS\' RENTALS ------'
puts "#{person1.name} - #{person1.rentals.count} books"
puts "#{person2.name} - #{person2.rentals.count} books"

puts '------ BOOKS\' RENTALS ------'
book1.rentals.map { |rental| puts "#{rental.book.title} - #{rental.person.name}" }
book2.rentals.map { |rental| puts "#{rental.book.title} - #{rental.person.name}" }

puts '------ RENTALS ------'
puts "#{rental1.date} - #{rental1.book.title} - #{rental1.person.name}"
puts "#{rental2.date} - #{rental2.book.title} - #{rental2.person.name}"
puts "#{rental3.date} - #{rental3.book.title} - #{rental3.person.name}"
