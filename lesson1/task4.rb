puts 'Введитe а'
a = gets.chomp.to_f
puts 'Введитe b'
b = gets.chomp.to_f
puts 'Введитe c'
c = gets.chomp.to_f

d = b**2 - 4*a*c

if d > 0
  x1 = (-b + Math.sqrt(d))/(2*a)
  x2 = (-b - Math.sqrt(d))/(2*a)
  puts "x1 = #{x1}, x2 = #{x2}"
elsif d == 0
  x = -b/(2*a)
  puts "x1 = x2 = #{x}"
else
  puts 'корней нет'
end
