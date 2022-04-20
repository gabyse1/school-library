module Validators
  def valid_integer_input(request)
    input = -1
    while input <= 0
      print "#{request}: "
      input = gets.chomp.to_i
    end
    input
  end

  def valid_bool_input(request)
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

  def valid_month_days?(day, month, year)
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
    day = valid_month_days?(date_d, date_m, date_y) if preday
    day
  end
end
