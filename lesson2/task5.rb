puts 'Введите день'
day = gets.chomp.to_i
puts 'Введите месяц'
month = gets.chomp.to_i
puts 'Введите год'
year = gets.chomp.to_i

days = [31,28,31,30,31,30,31,31,30,31,30,31]

if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
  days[1] = 29
end

number_date = 0
(0..month-1).each { |month_index| number_date += days[month_index] }
number_date -= days[month-1] - day

p number_date
