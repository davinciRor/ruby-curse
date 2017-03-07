puts 'Введите а'
a = gets.chomp.to_f
puts 'Введите b'
b = gets.chomp.to_f
puts 'Введите c'
c = gets.chomp.to_f

sides = [a,b,c].sort

result = "Треугольник"

if sides[2]**2 == sides[1]**2 + sides[0]**2
  result += " прямоугольный"
  if sides.uniq.size == 2
    result += ' и равнобедренный'
  end
else
  result += ' не прямоугольный'
  if sides.uniq.size == 2
    result += " но равнобедренный"
  elsif sides.uniq.size == 1
    result += " но равносторонний"
  end
end

puts result
