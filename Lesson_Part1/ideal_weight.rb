
puts "Ваше имя"
name = gets.chomp

puts "Ваш рост"
height = gets.chomp.to_i

ideal_weight = height - 110

if ideal_weight > 0
  puts "#{name}, ваш идеальный вес: #{ideal_weight} кг."
else
  puts "Ваш вес идеальный"
end
