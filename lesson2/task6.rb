bucket = {}

loop do
  puts "Введите название товара"
  good = gets.chomp
break if good == 'стоп'
  puts "Введите цену"
  price = gets.chomp.to_f
  puts "Введите количество товара"
  count = gets.chomp.to_f

  bucket[good] = {
    price: price,
    count: count,
    total_price: price * count
  }
end

bucket_price = 0
bucket.each { |key, value| bucket_price += value[:total_price] }

p bucket
puts "Цена за все: #{bucket_price}"
