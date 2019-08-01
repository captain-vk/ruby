
days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
result = 0
puts "Введите число"
number = gets.chomp.to_i

puts "Введите месяц"
month = gets.chomp.to_i

puts "Введите год"
year = gets.chomp.to_i

for i in 0..month - 2
  result += days[i]
end

result += number

if ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)
  result += 1
end

puts result
