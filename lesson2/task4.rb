#Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

vowels = ['a', 'e', 'i', 'o', 'u']
hash = {}
letters = ('a'..'z').to_a
letters.each_index do |index|
  if vowels.include?(letters[index])
    hash["#{letters[index]}"] = index + 1
  end
end
p hash
