puts 'Введите коэффициент a: '
a = gets.chomp.to_f

puts 'Введите коэффициент b: '
b = gets.chomp.to_f

print 'Введите коэффициент c: '
c = gets.chomp.to_f

d = b**2 - 4 * a * c
puts d

if d > 0
  x1 = (-b + Math.sqrt(d)) / (2 * a)
  x2 = (-b - Math.sqrt(d)) / (2 * a)
  puts "Дискриминант = #{d}, Корень №1 = #{x1}, Корень №2 = #{x2}"

elsif d == 0
  x =  (-b) / (2 * a)
  puts "Дискриминант = #{d}, Корень = #{x}"

elsif d < 0
  puts "Дискриминант меньше 0. Корней нет!"
end
