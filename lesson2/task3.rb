fib_arr = [1,1]
next_number = fib_arr[-1] + fib_arr[-2]
while next_number < 100
  fib_arr << next_number
  next_number = fib_arr[-1] + fib_arr[-2]
end
p fib_arr
