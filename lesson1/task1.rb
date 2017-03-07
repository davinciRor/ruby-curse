puts 'Введите ваше имя'
name = gets.chomp.to_i
puts 'Введите ваш рост'
growth = gets.chomp.to_i

weight = growth - 110

if weight >= 0
  puts "#{name}, Ваш идеальный вес #{weight}"
else
  puts "Ваш все уже оптимальный"
end
