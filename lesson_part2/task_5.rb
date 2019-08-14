
days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
result = 0
puts "Введите число"
number = gets.chomp.to_i

puts "Введите месяц"
month = gets.chomp.to_i

puts "Введите год"
year = gets.chomp.to_i

if ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)
  days[1] = 29
end

result = days.take(month - 2).sum + number
puts result
