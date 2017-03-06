puts 'Введите ваше имя'
name = gets.chomp
puts 'Введите ваш рост'
growth = gets.chomp

weight = growth.to_i - 110

if weight >= 0
  puts "#{name}, Ваш идеальный вес #{weight}"
else
  puts "Ваш все уже оптимальный"
end
