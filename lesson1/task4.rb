puts 'Введиту а'
a = gets.chomp.to_i
puts 'Введиту b'
b = gets.chomp.to_i
puts 'Введиту c'
c = gets.chomp.to_i

d = b**2 - 4*a*c

if d > 0
  x1 = (-b + Math.sqrt(d))/(2*a)
  x2 = (-b - Math.sqrt(d))/(2*a)
  puts "x1 = #{x1}, x2 = #{x2}"
else
  puts 'корней нет'
end
