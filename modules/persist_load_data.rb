module PersistLoadData
  def persist_data
    persist_data_people
    persist_data_books
    persist_data_rentals
  end

  def persist_data_people
    peopletemp = []
    @people.each do |person|
      person_obj = {
        class: person.class,
        id: person.id,
        name: person.name,
        age: person.age,
        parent_permission: person.parent_permission
      }
      person_obj['spetialization'] = person.spetialization if person.instance_of? Teacher
      peopletemp << person_obj
    end
    File.write('data/people.json', peopletemp.to_json)
  end

  def persist_data_books
    booktemp = []
    @books.each do |book|
      booktemp << { title: book.title, author: book.author, rentals: book.rentals }
    end
    File.write('data/books.json', booktemp.to_json)
  end

  def persist_data_rentals
    rentaltemp = []
    @rentals.each do |rental|
      rentaltemp << { date: rental.date, book: rental.book.title, person: rental.person.id }
    end
    File.write('data/rentals.json', rentaltemp.to_json)
  end

  def load_data_teacher(obj)
    Teacher.new(obj['spetialization'], obj['age'], id: obj['id'], name: obj['name'])
  end

  def load_data_student(obj)
    Student.new(obj['age'], id: obj['id'], name: obj['name'], parent_permission: obj['parent_permission'])
  end

  def load_data_people
    peopletemp = []
    if File.exist?('data/people.json')
      people_array = JSON.parse(File.read('data/people.json'))
      people_array.each do |obj|
        peopletemp << load_data_student(obj) if obj['class'] == 'Teacher'
        peopletemp << load_data_teacher(obj) if obj['class'] == 'Student'
      end
    end
    peopletemp
  end

  def load_data_books
    bookstemp = []
    if File.exist?('data/books.json')
      books_arr = JSON.parse(File.read('data/books.json'))
      books_arr.each do |obj|
        bookstemp << Book.new(obj['title'], obj['author'])
      end
    end
    bookstemp
  end

  def load_data_rentals
    rentalstemp = []
    if File.exist?('data/rentals.json')
      rentals_array = JSON.parse(File.read('data/rentals.json'))
      rentals_array.each do |obj|
        book_obj = @books.find { |book| book.title == obj['book'] }
        person_obj = @people.find { |person| person.id == obj['person'] }
        rentalstemp << Rental.new(obj['date'], book_obj, person_obj)
      end
    end
    rentalstemp
  end
end
