fib_arr = [1,1]

loop do
  next_number = fib_arr[-1] + fib_arr[-2]
break if next_number > 100
  fib_arr << next_number
end

p fib_arr
