puts 'Введите сторону a: '
a = gets.chomp.to_f

puts 'Введите сторону b: '
b = gets.chomp.to_f

print 'Введите сторону c: '
c = gets.chomp.to_f

array = [a,b,c].sort

a = array[0]
b = array[1]
c = array[2]

if a == b && b == c
  puts "Треугольник равносторонний"
elsif a == b || a == c || b == c
    puts "Треугольник равнобедренный"
elsif c**2 == a**2 + b**2
  puts "Треугольник прямоугольный"
end
